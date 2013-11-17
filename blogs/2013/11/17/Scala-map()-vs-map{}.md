I was wondering the other day what the difference really was, in Scala, between

<script src="https://gist.github.com/JohnMurray/7518029.js?file=map1.scala"></script>

and

<script src="https://gist.github.com/JohnMurray/7518029.js?file=map2.scala"></script>

So, I figured I'd take a look at the map function defined on the List class. I winded up
finding the definition in the `TraversableLike` trait as follows:

<script src="https://gist.github.com/JohnMurray/7518029.js?file=map-traversable-like.scala"></script>

Let's ignore the builder for now since it's the less important part of this question. We're
interested in the first set of parameters, `f: A => B`. This seems to be a normal argument
yet we can apply it in two different ways. That got me thinking a little bit and so I decided
to play around a bit to see if I can figure this out anecdotally, before looking up the proper
literature.

### Non-Function Arguments

I first wanted to try with some simple functions that didn't have functions as arguments to see if
this format is generally applicable. I came up with some simple tests.

<script src="https://gist.github.com/JohnMurray/7518029.js?file=normal-function.scala"></script>

So from this it seems to indicate that braces are not interchangeable with parenthesis. However,
it does seem that `"John"` and `{"John"}` are interchangeable. In fact, if we look at the REPL
we see:

<script src="https://gist.github.com/JohnMurray/7518029.js?file=braces-repl.scala"></script>

This may not be a surprise to some, but that means that something like `echo {"hello"}` can
really just be thought of as a shorthand for `echo({"hello"})`. But what about `{x => x * x}`.
We can assume that just returns a function, correct? So that would means we can assume that
these are functionally equivalent:

<script src="https://gist.github.com/JohnMurray/7518029.js?file=map3.scala"></script>

And, anecdotally, this seems to be true.

### Back to Functions

So based on our findings, what is the point of the curly braces and when would they be useful.
Let's do some experiments with a little more meat and see if we can find an answer. First let's try
a slightly larger map example.

<script src="https://gist.github.com/JohnMurray/7518029.js?file=map4.scala"></script>

Ah ha, so there is a good reason to use curly braces. It looks like the parenthesis version cannot
handle multiple statements and is only expecting a single expression. Furthermore, I found this bit
interesting as well:

<script src="https://gist.github.com/JohnMurray/7518029.js?file=func-val.scala"></script>

The same syntax using parenthesis cannot be used to define the function outside of the map unlike
the version with curly-braces. Very interesting.

### The Real Story

Okay, at this point I feel like I've made some interesting findings, but I'm curious what the
Internet has to say about such things. So I figured I'd let her weigh in. I came across a few
different posts:

+ [Scala Forums Posting, complete with appearance by Odersky][1]
+ [This SO Post][2]
+ [Another Scala Forums Posting][3]

Surprisingly, all three answers were by the same person. For someone strapped for time when it
comes to blogging, he sure does seem to make a lot of appearances on this topic. ;-D

All in all, there seems to be quite a bit of discussion with some grey areas still that I still
don't fully understand. In those cases the compiler seems to be the specification, which is never
preferable (IMO) for many reasons. Oh Scala, you are an interesting little language.


  [1]: http://www.scala-lang.org/old/node/2593
  [2]: http://stackoverflow.com/questions/4386127/what-is-the-formal-difference-in-scala-between-braces-and-parentheses-and-when
  [3]: http://www.scala-lang.org/old/node/10195
