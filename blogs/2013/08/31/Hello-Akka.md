# Getting Started with Akka

For those not familiar, [Akka][1] is a [Scala][3] library for implementing the
[Actor Model][2]. Technically you can use Java as well, but things are a little
more concise and idiomatic in Scala.

Let's get started shall we. The first thing you should have installed is [sbt][4].
Then you'll want to create a new folder for your project `hello-akka`. Within that
folder, let's create a `build.sbt` file with the following contents:

<!-- build.sbt gist -->
<script src="https://gist.github.com/JohnMurray/6400829.js?file=build.sbt"></script>

You can see that we just have some basic setup with names and versions. You'll also
notice that we're delcaring `akka-actor` and `akka-kernel` as our dependencies. The
main library is `akka-actor` which we will (obviously) define our actor in. The second
is a little less obvious, `akka-kernel`, and will be used to define our akka-instance
as a standalone setup (not as a library within another project).

The next thing we want to do is create a couple of actors to perform an asynchronous
hello-world:

<script src="https://gist.github.com/JohnMurray/6400829.js?file=HelloWorldActor.scala"></script>

<script src="https://gist.github.com/JohnMurray/6400829.js?file=Greeter.scala"></script>

Take note that these files were created within the directory `src/main/scala` within
the `hello-akka` directory. From the above, you'll notice that the HelloWorldActor
receives a `Tick` event and then sends a message to the `Greeter` actor which then
prints `"Hello, World"`. You may be wondering what is sending the `Tick` event to the
HelloWorldActor to start with. For this we have to define our kernel:

<script src="https://gist.github.com/JohnMurray/6400829.js?file=HelloWorldKernel.scala"></script>

This is the entry-point for our application. You can see that we are creating an instance
of the `HelloWorldActor` and scheduling a message be sent (`Tick`) every 500 milliseconds.

## Done!

That's all there is to creating a standalone Akka, pretty simple. There are various ways you
can run your application, but I feel the easiest is with scripts that ship with Akka. To add
that to your project, run the following script from within the `hello-akka` directory:

<script src="https://gist.github.com/JohnMurray/6400829.js?file=run.sh"></script>

I typically create a Makefile for running my project just because I find that easier. You could
do something like the following:

<script src="https://gist.github.com/JohnMurray/6400829.js?file=Makefile"></script>

And then just run `make run` to start your project. You should see something like the following:

<script src="https://gist.github.com/JohnMurray/6400829.js?file=akka-output"></script>



  [1]: http://akka.io
  [2]: http://en.wikipedia.org/wiki/Actor_model
  [3]: http://scala-lang.org
  [4]: http://www.scala-sbt.org/0.12.4/docs/Getting-Started/Setup.html