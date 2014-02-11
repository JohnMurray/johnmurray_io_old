# Infinite Scale - Part 1

So what does infinite scale mean? Well, infinite scale is really just
a way of thinking about application development when the scale is incredibly
large. The difference in how you design applications for very, _very_ large
scale is not much different than how it would be when dealing with the same
system at an _near_ infinite scale (since we can never _actually_ be infinite).

But what does an application designed for near infinite scale really look like?
Well, luckily for us, Pat Helland from Amazon has a [white paper][1] detailing
common structure and terminology for applications built at near-infinite scale.
The paper is a great read (highly recommend) and is easily understandable for the
non PhD types like myself.

However I should note that what is described in the paper is not quite concrete
(as one would expect when describing general patterns), so I plan to explore this
further. So, that is exactly what I'll be doing through this series. I will be
building a small'ish version of what is described in the white paper to see what
an application built for near-infinite scale actually looks like.

I should note up-front that this is for learning purposes only. I would not recommend
using any of the code presented here for production/real-world systems. The
application will likely have plenty of holes in the design, which is expected for
a learning exercise such as this. However, if you see a hole in my design or would
like to discuss something further, feel free to email me at "me at johnmurray dot io."


## Warm-Up

A laundry list of items about the project before I get started.

=Source Code=
    The source is [available on GitHub][2] and is broken out into
    phases (each it's own folder). 
=Language=
    It's all done in Ruby, but there is not a lot of _fancy_ stuff happening
    there so it should be easy to follow along for most.
=Other Tech=
    There really isn't any other tech. I've simplified most things down into
    plain ole' Ruby objects/classes. This means no DBs, queues, caches,
    load-balancers, cluster-management stuff, etc (at least outside of what
    is implemented per the project).
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




  [1]: http://cs.brown.edu/courses/cs227/archives/2012/papers/weaker/cidr07p15.pdf
  [2]: https://github.com/JohnMurray/infinite-scale-experiment
