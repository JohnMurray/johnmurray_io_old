# Contributing to Open Source

As a developer, we all benefit from open source software and at some point
we likely contribute _something_ to open source (big or small). For me this
has been relatively small and in the form of money, updating documentation,
refactoring code, small bug fixes, etc. 

More recently I've been thinking that I need to get more involved in developing
open source software. I've realized that this is no small decision. You are
dedicating a non-trivial amount of your personal time and you want to ensure
that this was not wasted. Toiling away to build the world's best toaster will
likely bring you little joy if know one makes any toast with it.

Being as this is an important decision, I wanted to document my thought 
process.


## Important Factors

When considering what is important to me in contributing to open source I
was basically able to identify the following factors

- How much use will the project (thus my work) get?
- How much will I learn by contributing to a project (new tech, learn from
  other, more experienced programmers, etc)
- How challenging will the work be?

## Possible Projects

Based on my current interests and skills, and projects that I am familiar with,
I have narrowed it down to the following 5 projects.

- [Ruby-Lang][1]
- [EventMachine][2]
- [Spray][3]
- [GitLab][4]
- Spray Router (own project)

## Pros

Let's break down the pros of each project

- __Ruby__
  - Practice up C skills
  - Gain experience with compiler/VM programming
  - Very high usage (potentially most rewarding in that regard)
- __EM__
  - Had a lot of fun using EM in the past
  - Relatively stable (established) Ruby library
- __Spray__
  - Use-cases would be really fun to solve (scale, performance)
  - Really practice on Scala mastery
  - Gain more experience in Akka
- __GitLab__
  - Would love to use it for myself and other people already use it 
    (thus rewarding)
  - Could apply my skills to introduce fun things (e.g. like doc-caching 
    via solr for fast search)
  - Could learn rails/ruby better (in context of large project)
- __Spray Router (own project)__
  - Build from start, fully understand
  - Learn Spray and practice Scala mastery
  - Build proper CI / Doc environment
  - Will overlap with work projects and may get to demo it's usage on
    our platform


## Cons

And now onto the cons

- __Ruby__
  - May not be as challenging as I would like it to be (or as interesting)
  - Barrier of entry is much higher for a first time project
- __EM__
  - May not be popular anymore (based on activity graphs in GitHub and
    general perception)
  - Doesn't seem to be under active development aside from bug-fixes
  - Reading v2 and v3 on the roadmap, it's development doesn't seem well
    thought out, and is a bit of a mixed bag
- __Spray__
  - Large learning curve
- __GitLab__
  - May not be super challenging work (just a web app after all)
- __Spray Router (own project)__
  - Will not learn from other contributors
  - Will not have large adoption at first since new project


## Lets Review

### Ruby
Ruby would allow me to practice my C skills as well as learn a new domain. It also
likely has the highest usage of any project listed and I would, theoretically, feel
the most gratification. However it doesn't fall within the domain of things I find
particularly interesting. __Ruby is out__

### EM

While I do enjoy EM, it seems to have fallen out of popularity (to some degree). 
While it is possible
to breathe new life into projects I'm not sure I want to take on or participate in
this task (just yet). Additionally, the documentation of EM regarding version 2 and
3 seems a bit _confused_. I'm not sure there is a clear direction with EM which I also
don't think is something I want to be a part of just yet. __EM is out__

### Spray

Spray seems to be gaining popularity and is within the domain of things that I find
interesting. Additionally, this would allow me to grow my newer Scala skills. However
I have worked with Spray only minimally so the learning curve would be greater.
__Spray is a contender__

### GitLab

I have minimally used GitLab but have enjoyed it. I could see contributing to this 
project. However, I wonder how long working on what is essentially a fancy web-app
will keep me entertained. However I do see a lot of room for improvement in the
project. __GitLab is a contender__

### Spray Router

This is something that I have been mulling over for some time and have done some
work with application-level routers at work. However starting my own project would
rob me of the community aspect and of knowing that my project was being used by
many people (at least at first). However, I would be able to further familiarize
myself with Spray. __Spray Router is a contender__

## Conclusion

After some thinking, and some sleeping, and some more thinking I have finally come
up with a game plan. I would most like to contribute to Spray but the learning
curve is going to be quite high, especially with my limited exposure to it. So,
as an alternative, I will work on my Spray Router project as a prelude to working
on Spray proper.

I believe that I can get enough adoption (from work) for the Spray Router to get
enough gratification to keep me motivated long enough to finish the project and
start contributing to Spray.

Now that I have a plan, I just need to do it. \*fingers crossed!\*



  [1]: http://www.ruby-lang.org
  [2]: http://rubyeventmachine.com/
  [3]: http://spray.io
  [4]: https://gitlab.com/gitlab-org/gitlab-ce/tree/master
