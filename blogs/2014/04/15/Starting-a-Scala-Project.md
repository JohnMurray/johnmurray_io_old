# Starting a Scala Project

When starting a new Scala project there are a few things that you want
do get setup correctly before starting your development work. These are
some of the things that I do for each new project.

> __Spoiler__ - I have created a GitHub repo [basic-scala-template][1] that 
> contains everything that is mentioned here.

## SBT

I setup all my projects as a standard SBT project (because why wouldn't you)
so hopefully you can find this useful. The first thing I do is download the
version of SBT that I want and add the launcher and the shell script local
to my git repo. This way I always have sbt available on whatever machine
that I am working on and I am able to make per-project changes to the
launcher. If you do this as well you will have to get used to typing `./sbt` 
vs `sbt`, but that is an easy change to make. 

As of right now, my project structure looks like the following:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=layout-1">
</script>

I will note that for the actual `sbt` script I usually just use one of
my own rather than the super-complex ones that ship with the SBT download. My
current sbt launch script looks like:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=sbt">
</script>

## Basic SBT Additions

Now that I have SBT setup for a project, I can start doing some basic
configurations that I figure I will need on all my projects. First I'm going
to add is the [sbt-revolver][2]. This is a very useful plugin that can run
your project in a forked JVM and reload it on a change. We can add this to
the project by adding the following to our `project/plugin.sbt`:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=plugins-line-1.sbt">
</script>

While I'm at it, I'm going to add one more plugin, [sbt-idea][3], that can 
generate IDE-specific files for IntelliJ IDE with a simple command `gen-idea`:


<script src="https://gist.github.com/JohnMurray/11116775.js?file=plugins-line-2.sbt">
</script>


## Template Build File

When using SBT I opt for the full `Build.scala` vs the DSL-like `build.sbt` file.
I find it easier and more straight-forward to work with. I like to break my
build file into several logical sections: resolvers, dependencies, build settings,
and the application build. My typical build-file looks like:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=Build.scala">
</script>

Even though this build file is pretty bare (_at the moment_) there are some key
things that I like to include as part of every build configuration. 

<dl>
  <dt>Scala</dt>
  <dd>
    Aside from specifying the version that I will be using for this project, I
    also specify some basic compiler options to output more verbose warnings and
    do some extra checks for me.
  </dd>

  <dt>Versioning</dt>
  <dd>
    I like to start each project as a snapshot version (0.0.1). I can then extend
    the build-file later with some publishing configurations to push snapshot versions
    to a repo (like Sonatype) on each successful build/commit/test-run/etc.
  </dd>

  <dt>Revolver</dt>
  <dd>
    Even though we added the `sbt-revolver` plugin to our `plugins.sbt` file earlier
    we still need to add the settings to our build to fully install it.
  </dd>
</dl>

## Style Checking

For me, this is a new addition but I generally like consistency in my projects (open
source and closed) when it comes to style. I've been playing around with various
style checkers, but I've settled on [Scalastyle][5] for now. I don't have much beyond
the standard, but I'm sure it'll evolve over time. I added the following to my
`plugins.sbt` file

<script src="https://gist.github.com/JohnMurray/11116775.js?file=plugins-line-3-4.sbt">
</script>

I've also updated our `buildSettings` in `project/Build.scala` by appending the
Scalastyle settings

<script src="https://gist.github.com/JohnMurray/11116775.js?file=scalastyle-build.scala">
</script>

As far as the build configuration goes, my configuration isn't far off the default you
get by running `sbt scalastyle-generate-config` so I won't list it here. 


## Testing

For testing I typically start with Specs2 and add from there. For this we add to the build
file simply:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=Build.specs2.scala">
</script>

I can easily add others in the same fashion. For example, if I were doing an Akka
project I would add the `akka-testkit` for the `spray-teskit` for Spray projects.

If the project I am building is open source, I have to think about CI what build
system I'm going to use. I personally prefer to use [Travis-CI][4] just because
it's so darn simple. Since this is usually the case I add the `.travis.yml` file:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=.travis.yml">
</script>


## Miscellaneous

As a final note, I like to add some basic files that I put in most projects:

<dl>
  <dt><code>.gitignore</code></dt>
  <dd>
    The baiscs for scala projects as well as IntelliJ project-files and general
    files (like `.swp` files and what not)
  </dd>

  <dt><code>readme.md</code></dt>
  <dd>
    I like to include a readme with all of my projects (open source or not) just
    as a <em>welcome</em> and a guide for navigating and working with the project.
  </dd>
</dl>


## Done!

Now that I'm done putting together all the pieces to get started, my final directory
structure is laid out in the following manner:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=layout-2">
</script>

As I mentioned in the spoiler up top, I have put this into a git repository for my
own (and possibly your) convenience [here][1]. You can start any new project using 
this template simply via:

<script src="https://gist.github.com/JohnMurray/11116775.js?file=clone-repo.sh">
</script>

If you find this useful (and I hope you do) then please fork [my repo][1] and customize
it to suite your needs. Feel free to send pull requests if you think I am missing
something awesome that you feel every Scala project should include.

__Enjoy!__





  [1]: https://github.com/JohnMurray/basic-scala-template
  [2]: https://github.com/spray/sbt-revolver
  [3]: https://github.com/mpeltonen/sbt-idea
  [4]: http://travis-ci.org
  [5]: http://www.scalastyle.org/
