[Pry][1] is a wonderful interactive environment for Ruby. It is (more or less)
a replacement to IRB. We already know that interactive environments are highly
useful and the Rails Console is a great example of utilizing that interactive
environment effectively. 

However, if you're like me, then you don't work in Rails. The majority of my
work is in custom Ruby programs, [EM][2]-driven programs and [Sinatra][4] APIs.
You don't get anything like Rails Console for free when you're building a custom
Ruby program. So, when you start up an interactive environment, you may find
yourself starting each session like so:

<script src="https://gist.github.com/2844201.js"> 
</script>

You may keep your console running just because you don't want to have to type
all of that junk again. But eventually you will restart your computer, close
your terminal, etc. and you will loose all of the work you put into setting up
your console environment. 

My question to you (and to myself), is why go through all this trouble when
creating your own console is so easy! Just create a __console__ file in the
root of your project and insert all of that code that you would normally put
into an interactive session. You can even get fancy with a little color output
and various, generic helper methods that are useful for debugging. A console
example from one of my [current projects] looks like the following:

<script src="https://gist.github.com/2844251.js"> 
</script>

In my console I:

- Load my project files
- Define test-data to work with
- redefine __PP.pp__ to use a shorter-width for printing out test-coordinates
- load Rack helper methods so that I can make calls to my Sinatra app from
within the console
- add the ability to reload my console
- define a helper object to call private methods on the Geofence class
- print a nice welcome message (colorized with CodeRay which is packaged with
Pry)

That's quite a bit of work if I were to do that each time I started a new
interactive Pry session. And to be honest, I just wouldn't. I would do the bare
minimum required to test something. With the console, I can have some other
niceties because I only have to write them once. So nice!

This has now become a mandatory step when _getting started_ on any new Ruby
project. I add some basics that I put into all of my console files and then
I evolve the console as the project moves forward. I can't imagine working
any other way (well... I can, I just don't prefer it).


  [1]: http://pry.github.com/
  [2]: http://rubyeventmachine.com/
  [3]: https://github.com/JohnMurray/geofence-server-example
  [4]: http://www.sinatrarb.com/
