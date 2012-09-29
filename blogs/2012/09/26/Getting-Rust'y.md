Have you heard of [Rust][1] (I'm not talking about iron oxide)? It's a new
systems language being baked up by the [Mozilla Foundation][2]. Currently
it is very new and unstable (in the sense that it will change a LOT by the
time is reaches version 1). It looks very interesting and is well worth a look.

From my VERY limited knowledge of the language, it looks like [C][3], [Go][4],
and [Ruby][5] had a child. However, I'm sure my opinion of this will change
greatly as I learn more about the language. All I can really say for sure is
that it looks like it's going to be a great/fun language to learn. How could
it not with a feature list consisting of:

+ pre-compiled (C/C++ compatible)
+ static typing, with type inference
+ simple concurrency model
+ lambdas everywhere (the way it should be)
+ immutable by default
+ move semantics ([good explanation here][6])


<br />
<br />


### Compiling
Okay, if we're going to play around with the language then we'll at least need
to compile it and get it up and running. For me, I had just setup a new Fedora
17 instance (no updates at this point) and to compile only required that I do:

<script src="https://gist.github.com/3805064.js?file=compiling-rust.sh"></script>

Do note that I use the `-j` option for `make` to speed things up on my
computer. I'd recommend to change the value of `-j` to however many cores your
computer has available. You might also need to run `make install` as sudo
if you do not have the necessary permissions. 

<br />
<br />



### Hello Rust
As is tradition, you have to force your newly compiled interpreter/compiler
to introduce itself to the world. And, in Rust, it's just about as boring as it
is in any other language:

<script src="https://gist.github.com/3805064.js?file=hello_world.rs"></script>

A slightly more exciting example (shamelessly stolen from rust-lang.org's
[tutorial][7]), a parallel game of rock-paper-scissors:

<script src="https://gist.github.com/3805064.js?file=parallel_rock_paper_scissors.rs">
</script>


### I Want More!
If you're like me, then you think that Rust could really turn out to be something
fun and awesome (I really recommend heading on over to rust-lang.org to learn
something more substantial)! But, I'm not here to give a thorough walk-through
of the language. I'm more or less just giving a shout-out to what could really
be a very interesting systems-programming language.


  [1]: http://rust-lang.org
  [2]: http://www.mozilla.org/foundation
  [3]: http://en.wikipedia.org/wiki/C_(programming_language)
  [4]: http://golang.org
  [5]: http://ruby-lang.org
  [6]: http://stackoverflow.com/questions/3106110/can-someone-please-explain-move-semantics-to-me
  [7]: http://dl.rust-lang.org/doc/0.3/tutorial.html#first-impressions
