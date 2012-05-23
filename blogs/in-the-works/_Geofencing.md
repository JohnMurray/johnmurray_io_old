# Abridged Version
You can represent a geofence as a series of square blocks. These square blocks
represent an estimation of your fence (which we'll think about as a normal 
polygon).
Using the center-points for each of these blocks, we can store the estimated
polygon in Mongo as an array of coordinate pairs. We can then use some of
Mongo's built-in query features to determine if a coordinate lies within (or
outside of) the polygon. Viola, geofencing with Mongo. If I've peaked your
interest (and you have the time), please read the full version.

# tl;dr Version
The rest of the document will go as follows:

+ [What is a Geofence?][1] <sub>a general rundown</sub>
+ [What do We Need to Get Started?][9] <sub>setting up a sample project</sub>
+ [Polygons and Grids][2] <sub>a little bit o'math</sub>
+ [Grids and Mongo][3] <sub>storing conceptual grids in Mongo</sub>
+ [Boundary Crossing][4] <sub>mixing in some practicality</sub>
+ [Putting it All Together][5] <sub>let's make something useful</sub>
+ [Better Options?][6] <sub>any ideas?</sub>


## What is a Geofence?
A geofence is a conceptual fence around some geographically defined area. For
example, the company I am currently working for (at the time this was
written) deals in car-centric telemetry. Specifically we process a lot of
geo-spatial data. We use this to allow users to create a conceptual fence
around their car. When their car reports outside of their fence, we can then 
send them a notification. This is useful for making sure your car isn't stolen
or your children aren't going somewhere without your permission. If it's still
a little fuzzy, I'll draw you a pretty picture:

![Pretty geofence picture] [7] 

Just like a normal fence, you can either be inside or outside of the fence.
Depending on what state you are in, we can create a system to act accordingly.
Perhaps you want a reminder when you leave work. In that case you would create
a fence around your workplace and you would instruct your system to send you
a reminder when you leave that fence. 

For the rest of this blog post, I'm going to talk about how to get started
with geofences in your next (awesome) project.

## What do We Need to Get Started?
Well, for this post I'm going to be working with Ruby and Mongo. I'll be using
Ruby for the programming examples (honestly, what else would I use it for?)
mainly because it's my preffered language.
Dont' worry, there will be no Rails in this post so you non-Rails folk can keep
reading. I'll be using Mongo for data-storage and I'll be taking advantage of 
the geospatial query features available in v2.0 and above. So, if you want to 
follow along, all you need to install is Ruby and Mongo (and why wouldn't you
have that installed already... doesn't everyone?).


## Polygons and Grids
talk about representing polygons as grids. This is where we're
going to get into a little bit of math (area estimation problems
and what not)

Getting right into the technical details, we need to first think about how
we are going to represent, create, and store our fences. Polygons are nice
for representing the fence in the UI. However the example I showed you above 
was rather simple. So, the question is, how do we store and reason about a
more complex polygon?

![A complex geofene] [8]

Sure, you may be able to store it as an array of coordinate-pairs, but for my
particular implementation this is not going to work. We need a simpler
representation such that we can compute the _inside/outside_ check with
minimal overhead (in terms of complexity and performance).

Since polygons do make for a great UI to represent fences, let's assume that
our fences should behave like polygons. That is if I draw a circle, I should
be at the boundary of my fence when I am _r_ distance away from the center-point
of the circle. But, as discussed, we are not going to store our fences as
polygons. Instead, we are going to store our polygons as a set of squares. The
squares will estimate the polygon. Think of drawing your polygon on a grid and
then only shading in the blocks for which the center-point (of the grid-block)
is included within the boundary of the polygon. 

![a polygon drawn on a grid][10]
<sub>A polygon with a grid overlay</sub>

![the estimation of the polygon][11]
<sub>An estimation of the previous polygon</sub>

The more granular our grid, the more accurate our estimation will become.
However, keep in mind that the more granular your grid becomes, the more data
you will have to store and computer over. I prefer this approach because the
grid-size can be altered depending on the size of the fence. For example a
fence the size of a parking lot vs a fence the size of the United States.

Okay, this sounds nice in theory but, it's time to talk about how we are
going to compute this estimation. My algorithm is based off of a simple
[polygon area-estimation alorithm][12]. Basically, the steps are:

1. Get the bounds of your polygon
2. Create a grid to overlay your polygon
3. Split your polygon into horizontal sub-sections at each vertice
4. For each sub-section, include the grid-blocks that lie within the polygon

I'll assume that step 1 and 2 are pretty easy to understand. For step 3, I
have included a visual below:

![polygon split into sub-sections][13]

Step 4 is a little more complicated and I'll break it down further to the
following steps:

1. 


## Grids and Mongo
now that we've defined the grids, we can talk about how those
will translate to storage within Mongo. Also talk about using
the built-in features to search for the fences, etc.

## Boundary Crossing
Talk about how boundary crossing is really useful for making
geofences not suck so much (at least my implementation)

## Putting it All Together
This is where we may want to talk about some demo that I have put
together in github to demonstrate all I've talked about so far.

## Better Options?
Have a better option? Please contact me and we can talk about it. I'm
always open to learning a new approach and seeing things from a different
perspective. It'll be fun! :-)




  [1]: #what_is_a_geofence
  [2]: #polygons_and_grids
  [3]: #grids_and_mongo
  [4]: #boundary_crossing
  [5]: #putting_it_all_together
  [6]: #better_options
  [7]: /blog-files/geofence/fence_on_map.png
  [8]: /blog-files/geofence/complicated_fence_on_map.png
  [9]: #what_do_we_need_to_get_started
  [10]: /blog-files/geofence/polygon_on_grid.png
  [11]: /blog-files/geofence/polygon_estimated.png
  [12]: http://alienryderflex.com/
  [13]: /blog-files/geofence/polygon_sub-sections.png
