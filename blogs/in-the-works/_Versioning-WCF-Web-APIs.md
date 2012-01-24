# Why?

Although it doesn't seem like it would be that hard of a concept (and it's
really not), there is no real good documentation on how to version your
WCF Web API. Yes, Microsoft has a long article [here][1] but, I don't think
this makes for a decent web API. Imagine for a moment if I were to version
my service contracts in order to make my breaking changes. Let's also imagine
that I have two contracts, `UserInfo` and `CarInfo`. Then we can reasonably
say that I might have URLs that look like:

          http://api.mysite.com/UserInfo/<MethodName>
    http://api.mysite.com/CarInfo/<MethodName>

Now, what happens when I need to make some breaking changes to say **just** the
`UserInfo` service contract. Now our URLs might look like:

          http://api.mysite.com/UserInfo/<MethodName>
    http://api.mysite.com/UserInfoV2/<MethodName>
    http://api.mysite.com/CarInfo/<MethodName>

Now if the user wants to use the latest and greatest then, they need to be
using UserInfoV2 and CarInfo. This is no good. What if you had 20 endpoints
and they were all at different version numbers? How would your client know
what to use? Would you give them a big list and tell them, these are the latest
API endpoints? What if you introduce new endpoints? Do you give them a version
of 1 even though the rest of your endpoints may be at version 3 or 4? Stop and
think about this for a moment. Is this really how you want people using your
API that you have invested so much into? Hopefully the answer is no. So, what 
is a better way?

# Doing it the Right Way

If you take a look at some key APIs out there ([Google Maps][2] for example),
then you'll start to notice a common way in which they version their APIs. They,
by some means, allow a way for their user to pass in an explicit version number
or, if no version number is given, serve them the latest API. I'm a big fan of
putting the version into the request URL such that our requests might look like:

          http://api.mysite.com/UserInfo/<MethodName>       #version 2
    http://api.mysite.com/v1/UserInfo/<MethodName>  #version 1
    http://api.mysite.com/v2/UserInfo/<MethodName>  #version 2

This offers a clean separation of versions. It makes it very clear to the end
user what version they are using and there is little room for confusion. So,
how do you go about setting this up on IIS? 

On your server, create a folder that will contain all of API versions. Perhaps
`C:\inetpub\wwroot\mysite-apis` and inside that folder create a folder for
each version such that your directory structure looks like

          \
    |--v1\
    |--v2\
    |--v3\
    |--...


Now, deploy your various API versions to their respective folders on the server.



  [1]: http://msdn.microsoft.com/en-us/library/ms731060.aspx
  [2]: http://code.google.com/apis/maps/documentation/javascript/basics.html#Versioning
