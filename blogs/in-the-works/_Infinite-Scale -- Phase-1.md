# Infinite Scale - Part 1

So what does infinite scale mean? Well, infinite scale is really just
a way of thinking about application development when the scale is incredibly
large. The difference in how you design applications for very, _very_ large
scale is not much different than how it would be when dealing with the same
system at an _near_ infinite scale (since we can never _actually_ be infinite).

All of my assumptions about how applications are designed in light of such scale
will be taken from a [white paper][1] out of Amazon by Pat Helland. This paper is
a great and easy read, but it leaves a lot to be imagined when it comes to knowing
what such a system would actually look like. So, to that note, that is what I
will be exploring here. 

I'll be building a downsized version of an application architecture meant for
near-infinite scale per the guidelines laid down by Pat Helland. Obviously this
is not a real-world application and will probably have plenty of holes in the design.
As the disclaimer says, this is just for fun (and education). However, if you see
a hole in my design or would like to discuss something further, feel free to email
me at "me at johnmurray dot io."


## Warm-Up

A laundry list of items about the project before I get started.

=Source Code=
    The source is available on GitHub [here][2]. It is broken out into
    phases (each it's own folder). 
=Language=
    It's all done in Ruby, but there is not a lot of _fancy_ stuff happening
    there so it should be easy to follow along for most.
=Other Tech=
    There really isn't any other tech. I've simplified most things down into
    plain ole' Ruby objects/classes. This means no DBs, queues, caches,
    load-balancers, cluster-management stuff, etc.
=Phases / Parts=
    I have divided up the project into manageable / digestible parts. Each 
    part in the series will cover one corresponding phase of development 
    in the project (see the [repo][2]).


## The Code

Drawing from my experience working in ad-tech, let's start with a simple campaign
service. This service will update basic campaign information (sans targeting
data). 


+ TODO:  simple version of campaign service (no sharding)
+ TODO:  show db layer (no sharding)
+ TODO:  add sharding (db first and then service)
+ TODO:  show service-config ru file and Procfile
+ TODO:  show router and updated Procfile
+ TODO:  some end-to-end curl calls 


----

## Related Posts

+ Part 2
+ Part 3




  [1]: http://cs.brown.edu/courses/cs227/archives/2012/papers/weaker/cidr07p15.pdf
  [2]: https://github.com/JohnMurray/infinite-scale-experiment
