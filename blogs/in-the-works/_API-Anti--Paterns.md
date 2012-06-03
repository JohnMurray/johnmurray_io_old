There's a lot we can learn from Microsoft, some of it from well designed
software and most of it from poorly designed software. This particular
post is about the latter. 

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

___Anit-Pattern #1___ - Organize your standard library in a way that makes no
logical sense the user.

I had to include the _System.XML__ DLL into my project
for this to work?? For searializing to JSON?? (VS reported the error on line 6
in the example above.) This is an aweful orginization of the standard lib.

Now, I used built-in data structures so that the serialization would/should work
properly. After all, they are part of the standard lib! So, I would expect the
serialized JSON to look like:
<script src="https://gist.github.com/2848335.js?file=expected_json.js">
</script>

___Anti-Patern #2___ - Write code that doesn't follow standards or user-expectations

Nope, instead the JSON comes out looking like this:
<script src="https://gist.github.com/2848335.js?file=actual_json.js">
</script>

WHAT THE HECK! Who in the world would think a key-value data-structure would
translate to an array where each key-value pair is it's own object!? If that
makes any sense to you then, please, explain it to me. 

___Anti-Pattern #3___ - Provide an alternative method that provides the correct
functionality, give it a confusing name, and package it with a huge library so
that if you only need that one class then you're screwed. 


