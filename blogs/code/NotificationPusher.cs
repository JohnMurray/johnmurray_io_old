using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Net;
using System.Collections.Specialized;
using System.Configuration;

namespace Mavizon.Utilities
{
    /// <summary>
    /// A simple utility for pushing notifications to the new
    /// Notification Service (NS). Well okay, it's .NET so nothing
    /// can ever really be that simple. 
    /// </summary>
    public class NotificationPusher
    {
        private static NameValueCollection _appSettings = null;
        private static NameValueCollection AppSettings
        {
            get
            {
                if (_appSettings == null)
                    _appSettings = ConfigurationManager.AppSettings;
                return _appSettings;
            }
        }
        private static String NSUrl
        {
            get
            {
                return AppSettings["NS_URL"];
            }
        }

        public static bool Push(NotificationDataContract notification)
        {
            // serialize the request in json
            MemoryStream jsonStream = new MemoryStream();
            DataContractJsonSerializer ser = new DataContractJsonSerializer(
                typeof(NotificationDataContract));
            ser.WriteObject(jsonStream, notification);

            // send the request
            WebRequest request = WebRequest.Create(NSUrl);
            request.Method = "POST";
            request.ContentLength = jsonStream.Length;
            request.ContentType = "application/json";
            Stream requestStream = request.GetRequestStream();
            requestStream.Write(jsonStream.ToArray(), 0, (int)jsonStream.Length);
            requestStream.Close();
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();


            // check the response
            var statusCode = response.StatusCode;
            return statusCode == HttpStatusCode.OK;
        }
    }

    /// <summary>
    /// A data contract to give the new NS data in the format that it expects.
    /// </summary>
    [DataContract]
    public class NotificationDataContract
    {
        [DataMember(Name = "user_id")]
        public int? UserId { get; set; }

        [DataMember(Name = "car_id")]
        public int? CarId { get; set; }

        [DataMember(Name = "notification_definition_id")]
        public int? NotificationDefinitionId { get; set; }

        [DataMember(Name = "template_data")]
        public JsonDictionary<String, object> TemplateData { get; set; }

        [DataMember(Name = "key")]
        public JsonDictionary<String, object> Key { get; set; }
    }


    /*
     * Workaround since the .NET library is SO FREAKING RETARDED!
     * 
     * <rant>
     *   So apparently the JSON serialer for data contracts has NO FREAKING
     *   CLUE how to properly convert a Key-Value data stcture into JSON.
     *   Seriously, who thouth that
     *   
     *   new Dictionary<String, object> {
     *     {"hello", "world"},
     *     {"one", "two"}
     *   }
     *   -- and --
     *   [
     *      {"Key" = "hello", "Value" = "world"},
     *      {"Key" = "one", "Value" = "two"}
     *   ]
     *   
     *   are equivalent? Whoever it was, I hate them. Apparently there is a
     *   JavaScript serializer that will do this right but I have to include
     *   the entire System.Web DLL to do it (Seriously!). Honestly, they must
     *   not know that JSON stands for JAVASCRIPT Object Notation. Shouldn't
     *   the JSON Serializer and the JavaScript Serializer do the EXACT SAME
     *   THING!?!?!?!?
     *   
     *   Curse you .NET!!!  (**Shake fist at sky in frustration)
     *   
     *   I'm exhausted now... I'm gonna programin IronRuby from now on...
     * </rant>
     */
    /// <summary>
    /// See (in-code) above rant for reasoning.
    /// </summary>
    /// <typeparam name="K"></typeparam>
    /// <typeparam name="V"></typeparam>
    [Serializable]
    public class JsonDictionary<K, V> : ISerializable
    {
        Dictionary<K, V> dict = new Dictionary<K, V>();

        public JsonDictionary() { }

        protected JsonDictionary(SerializationInfo info, StreamingContext context)
        {
            throw new NotImplementedException();
        }

        public void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            foreach (K key in dict.Keys)
            {
                info.AddValue(key.ToString(), dict[key]);
            }
        }

        public void Add(K key, V value)
        {
            dict.Add(key, value);
        }

        public V this[K index]
        {
            set { dict[index] = value; }
            get { return dict[index]; }
        }
    }

    /// <summary>
    /// Basically, the custom JsonDictionaryClass doesn't have the 
    /// nifty little constructor that the Dictionary class does and the
    /// readability of the code is SO much higher with that in place. So,
    /// the easiest thing to do what to write an extension method that
    /// would convert from an IDictionary object to a JsonDictionary object.
    /// </summary>
    public static class IDictionaryExtension
    {
        public static JsonDictionary<K, V> ToJsonDictionary<K,V>(this IDictionary<K, V> dict)
        {
            if (dict == null)
                return null;
            var jsonDict = new JsonDictionary<K, V>();
            foreach (var key in dict.Keys)
            {
                jsonDict[key] = dict[key];
            }
            return jsonDict;
        }
    }
}
