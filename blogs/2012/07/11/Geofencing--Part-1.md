# The Series
"Series about what?" you may ask. Well, geofencing of course. I'm going to
blather on about what they are, why there cool and why should you care,
how to build (a simple) one, and when that's all said and done I'm going
to show you a long-winded video-tutorial of how to use my sample 
geofence-server.

I've split this blog series into three parts. For you few excited folks out
there, worry much! I've not yet written the other parts in the series, but
I imagine they'll make there way on out here sooner or later. 
I am splitting up the posts so that my readers
_(you)_ can feel accomplished as they work there way through the sections.
_(Well, I'm splitting it up mostly so I can feel accomplished in finishing
something, but I like the latter description so we'll stick with that.)_
I've split it up as follows:

- What is \[a] geofence/geofencing? \[[_this_][1] post]
- How to build your own geofence-server with Ruby and Mongo \[[link][2]]
- A walk-through of a sample geofence-server, built just for you \[[link][3]]

Now, on to the blathering!

<br />
---
<br />

# What is \[a] Geofence/Geofencing?
## General Description
A geofence is a conceptual fence around some geographically defined area. For
example, the company I am currently working for deals in car-centric telemetry.
Specifically, we process a lot of geo-spatial data. We use this to allow users
to create a conceptual fence around their car (a geofence). When the car
reports outside of the fence, we can send them a notification. 

This is useful for making sure your car isn't stolen, tracking your children,
setting reminders for yourself, etc. If the idea of a conceptual fence is
still a little fuzzy, I'll draw you a pretty picture:

![pretty geofence picture][4]

Some simple properties that a geofence might include:

- If the user inside or outside of the fence
- If the user traveled into (from outside of) the fence (and vice versa)
- How long the user been inside or outside of the fence

Conceptually, a geofence is by no means a profound idea. So, why do we care?



## So Why Geofences?
Let's face it, geofences are sexy. Apps that use user's geo-spatial data
is the next step in user-engagement. With geofences, we can interact with
our users when they're on the move; enjoying life and not spending countless
hours in front of a computer. Apple realizes this to the point that they are
including [geo-spatial reminders][10] in iOS (probably using geofences of some
sort). 

And the possibilities are endless! Sure, everyone's going for the obvious
answers right now, such as: alerts, reminders, etc.; but there are so many
opportunities that haven't been explored. What if Facebook used geofences
in their next mobile app to determine how many people attended an event?
They could use the GPS position of everyone running the FB app on their
phone to determine who actually showed up. And guess what, they could easily
do that with geofences! _(Yeah maybe it's creepy, but it's cool!)_

I'm sure there are many more use-cases for geofences but I'll leave that
for you to dream about. _(What? You're dreams aren't location-aware? Hmm...
Interesting)_


## Building Geo-Spatial Apps
There are several approaches to implementing geofences. You can use built-in
features from several database engines. You can roll your own from scratch
(because obviously your approach will be way awesome!). Or, you could take
portions from various technologies to hack together a geofence engine/server.

When thinking about implementing your own server, you'll want to
think about several important pieces. 

- How are you going to store the data?
- Does the size of the fence matter?
- What algorithm will you use to determine if someone is inside or outside of
the fence?
- Does your storage model impact your algorithm and if so, is that
good or bad?
- Is speed important from the beginning? How does that impact your
algorithm?
- Etc.

It's a lot of work. If you're working on a prototype, side-project, or
just playing around; you'll probably want to utilize some existing
technology or find a good introduction/blog (like [this][1] one!).


If you're curious about geo-spatial data-processing in general, 
check out some of these articles as well:

- [Spatial Indexing with Quadtrees and Hilbert Curves][5]
- [Hilbert Curves][6]
- [Geofencing with Rails and MySQL][7]
- Computational Geometry (chapter 9) in [Algorithms in a Nutshell][8]
- [Ray Casting for PIP problems][9]

## Available Services
And finally, to wrap things up, here is a list of sites that provide
geofence services:

- [Geoloqi](https://geoloqi.com/)
- [maponics](http://www.maponics.com/trial-predefined-geofences-today/)
- [Urban Mappings](http://www.urbanmapping.com/content/data-and-services)
- [Loc Aid](http://www.loc-aid.com/)
- [locationlabs](http://www.locationlabs.com/products/geofencing/)

I'm sure there are more that I am forgetting, but you get the point. There
are quite a few services out there and geofencing is going to be too
important to ignore.

## Part 2
Well, that's all I have for you right now. If you think you're ready, head
on over to [Part 2][2] for a whirlwind introduction on building your own
(simple) geofence server with Ruby and Mongo. 




  [1]: #
  [2]: /log/pre/_Geofencing--Part-2.md
  [3]: /log/pre/_Geofencing--Part-3.md
  [4]: /blog-files/geofence/fence_on_map.png
  [5]: http://blog.notdot.net/2009/11/Damn-Cool-Algorithms-Spatial-indexing-with-Quadtrees-and-Hilbert-Curves
  [6]: http://en.wikipedia.org/wiki/Hilbert_curve
  [7]: http://launchany.com/geofencing-with-ruby-on-rails-and-mysql/
  [8]: http://www.amazon.com/Algorithms-Nutshell-Dektop-Reference-OReilly/dp/059651624X
  [9]: http://en.wikipedia.org/wiki/Point_in_polygon#Ray_casting_algorithm
  [10]: http://www.macworld.com/article/1160435/ios5_reminders.html
