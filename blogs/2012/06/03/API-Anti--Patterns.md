There's a lot we can learn from Microsoft, some of it from well designed
software and <s>most</s> some of it from poorly designed software. 
This particular post is about the latter. 

I was working in .NET today (yes, it was a sad day) and I needed to do the
following:

- Serialize an object to valid JSON
- Send that JSON to a HTTP service via an HTTP POST
- Verify the response (200 status code)

Sounds fairly simple. In Ruby, it looks something like this:
<script src="https://gist.github.com/2848335.js?file=example.rb">
</script>

I would expect the .NET version to be fairly similar (but longer of course).
However, I was a little off in my assumptions. Let me walk you through the
steps I took just to get the same functionality in the Ruby code above. As
we go along, I'll point out the anti-patterns found in the .NET standard lib.

#### Step 1 - Defining a Data Contract
<script src="https://gist.github.com/2848335.js?file=MyObjectDataContract.cs">
</script>
Nothing out of the ordinary here. Everything seems to be going well so far. I've
defined my basic object that I would like to serialize to JSON and life is
peachy.

#### Step 2 - Serialize the JSON
Based on what I found on the internet, this should suffice:
<script src="https://gist.github.com/2848335.js?file=SerializeMyObject.cs">
</script>

<br />

___Anit-Pattern #1___ - Organize your standard library in a way that makes no
logical sense

I had to include the _System.XML_ DLL into my project
for this to work for searializing to JSON?? (VS reported the error on line 6
in the example above.) This is an aweful orginization of the standard lib. Why
do I need to include _System.XML_ in order to use the JSON serializer?!?!?

<br />
_Deep breath... Okay, let's continue._

<br />

I used built-in data structures so that the serialization would/should work
properly. After all, they are part of the standard lib! So, I would expect the
serialized JSON of my data contract to look like:
<script src="https://gist.github.com/2848335.js?file=expected_json.js">
</script>

<br />

___Anti-Patern #2___ - Write code that doesn't follow standards or user-expectations

Nope, instead the JSON comes out looking like this:
<script src="https://gist.github.com/2848335.js?file=actual_json.js">
</script>

WHAT THE HECK! Who in the world would think a key-value data-structure would
translate to an array where each key-value pair is it's own object!? If that
makes any sense to you then, please, explain it to me. 

<br />

___Anti-Pattern #3___ - Provide an alternative method that provides the correct
functionality, give it a confusing name, and package it with a huge library so
that if you only need that one class then you're screwed. 

Come to find out, there is a correct implementation of a JSON serializer that is
called _JavaScriptSerializer_ that lives in the System.Web DLL. Okay, if it's
not confusing already that Microsoft is drawing a distinction between JSON and
JavaScript serialization, they make sure that if you want proper JSON 
serialization you have to include the _entire_ System.Web DLL. Seriously!?

I'm just working on a simple utility project that will assist other
systems in our infrastructure. This project will be utilized by a variety
of project types. I can't, in good conscience, force every project for carry
around a dependency of System.Web. So, off to the interwebs I go to find
another solution. 

<br />
...

<br />

Okay, I'm back and I have a solution!
I'm going to rewrite the entire application in Ruby! Yep... That should do
the trick. 

<br />

___Anti-Pattern #4___ - Make fixing your dumb mistakes require a lot of
boiler-plate code that clutters up the user's code-base.

Ah, if only it were that simple. What I really found on the webs
was how to write a wrapper-class to the built-in Dictionary class that would
serialize correctly. 

<script src="https://gist.github.com/2848335.js?file=JsonDictionary.cs">
</script>

This class just uses a Dictionary as the underlying data-store and serializes
correctly. The downside is that it really hides a lot of functionality that
is given by the built-in Dictionary type. One really useful feature it is
missing is the collections-constructor:

<script src="https://gist.github.com/2848335.js?file=ExampleDictionaryConstructor.cs">
</script>

Well, I just can't do without those nicities. That's an easy fix though, I
just need to be able to call a method, such as _ToJson()_, on a Dictionary
object.

<script src="https://gist.github.com/2848335.js?file=Dictionary.ToJson.cs">
</script>

There we go, now I can just call _ToJsonDictionary()_ on any IDictionary
object right before serializing to JSON. Finally, we have working serialization!

#### Step 3 - Send JSON via HTTP POST

In terms of length and complexity, send a request isn't too cumbersome of a 
process. Assuming that we have already serialized the JSON into a Stream
object, sending our request looks like the following:

<script src="https://gist.github.com/2848335.js?file=SendRequest.cs">
</script>

If we look back at the Ruby example above, you'll notice that almost all of the
code is focusing on sending the request. So, as far as sending web-requests is
concerned, the .NET version is comparable in terms of length. 

However, one thing to think about—when is the request sent? Well, in this case,
it wasn't. Yep, you read correctly, the request in the above example was never
made. You might say, _"Of course it never sent, you obviously have to call some
type of Send() method or something similar."_ Well, that would be the
_sensible_ thing to do now wouldn't it.

<br />

___Anti-Pattern #5___ - Implicit is better than explicit (especially when it
is non-obvious)

The request is sent when you ask for the response. Yes, that does make sense
if I am interested in the response. However, if I just want to "send and
forget" then you would use the following to make the request:

<script src="https://gist.github.com/2848335.js?file=SendWebRequest.cs">
</script>

Sure... that's real intuitive. 


#### Step 4 - Verify the response status code

Finally! We've made sense of the .NET framework (oxymoron?) and can finally
verify the reponse status code. This part is so simple, it'd be a real challenge
to screw this one up. It is simply:

<script src="https://gist.github.com/2865507.js?file=CheckResponse.cs">
</script>

<br />
<br />

### Closing Thoughts
Holy crap Microsoft...
