# Building Your Own Geofence Server


__Blog Post Flow__

- Introduction
  - Blog-post greetings.
  - Overview of how the post is organized (the approach/steps we'll take)
  - Mention cookie at the end of the post, althoug not directly saying
    what it is (the example geo-fence server)
  - mention that our geofence-server is conceptual and therefore does
    not deal with real coordinate values. (aka - it does not deal with
    negative values; only positive integers)

- Conceptual Approach
  - Advantages of Mongo DB
    - We know that we want to re-use existing software to make our
      lives easier. So, explain some of the geo-spatial features
      that are available in Mongo. Mention that we want ot figure
      out how to utilize these features even though geofencing is
      not directly supported.
  - Geofences as Grids
    - Talk about how if we represent polygons as grids, then we can
      take advantage of the features that MongoDB offers.
    - Talk about how we are going to query for the geofences (stored
      as points)
  - Turning Polygons into Grids
    - Sticking with the concept of "working our way backwards," we'll
      explain how we are going to transform our polygon (for our
      geofence) into a grid that we can then use with Mongo. 
    - For this, make sure to link to the "estimate-area" function in
      C.

- Building our Grid
  - Go over the grid-creation function
  - Show some code with GitHub

- Estimating the Polygon
  - Go over the estimation function
  - Show some code with GitHub

- Storing the estimation in Mongo DB
  - Explain the storage-format
  - Explain the index
  - Go over the transformation function (the function that transforms
    our current data-structure into the Mongo DB structure)
  - Show some code with GitHub

- Query the DB (Mongo)
  - Show how to query the DB within Mongo Shell
  - Show some code with GitHub to explain how this is
    translated to the Mongo DB (Ruby) Driver




# Hello!

Well, it looks like I might have peaked your interest enough from the
previous post for you to keep reading. Good for me! If you've stumbled
across this post, then you might want to know that it is part of a series
(of which you are reading part 2). If you wish to read (or re-read) part
1, you can do so [here][1].

In this post, I'm going to walk you through the mechanics of creating a
(very) simple geofence server. We'll start first with the conceptual
approach that we will be taking, then we'll see how we can make those
ideas a reality. And, when it is all said and done, I have a little
surprise for you.


# Conceptual Approach

Before we get into the nitty-gritty details, we'll go over the conceptual
approach that we will be taking. My hope is that the theoretical foundation
will aid in understanding the concrete details. 

### Utilizing Mongo

As we're planning our geofence server, we know we want to use existing
technologies, where possible, to aid in development time. In this example,
we're going to use some of the geo-spatial indexing and search features
that are available in Mongo. 

In particular, Mongo allows you index Lat-Lon points and search within
a specified radius. To visualize this, I've put together a map full of
points (on the left) and a nearby-search query with a specified radius
(on the right) for you below.

![Mongo geo-spatial index and query visualization][2]

Although Mongo does not currently provide support for full-featured 
geofences, this particular feature will save us a lot of time as we
build our own geofence server.

### Geofences as Grids

Knowing that we can utilize Mongo's geo-spatial indexing capabilities
with points, we now have to think about how we can store our geofence
within Mongo as a set of points (so that we can most take advantage
of the hard work that the open source community has put into Mongo).

My approach is to visualize that we are drawing our geofence (really
just a polygon) on a grid. Then we can estimate our polygon by using
only the grid-blocks that lie within the polygon (or at least their
center-points lie within the polygon). We can then take the estimated
polygon (the set of grid-blocks) and get their center-points. It is these
center-points which we can then store in Mongo.

![polygon estimation with grids, grid-blocks, and center-points][3]

You might thinking that this is all fine and dandy, but how are we going to
use this to determine if someone or something is inside or outside of the
fence?

Simple! If we think of each point as the conceptual grid-block, from which
the point was derived, then we can do a nearby-search in Mongo with a
radius of one-half the length of the diagonal of the grid-block (plus a
little extra to account for some rare edge-cases). To illustrate:

![polygon query with points and nearby-search][4]

Voilà! Now if you search the points (your geofence) with a specific point
and the pre-determined radius, you'll either get back 0 points (meaning
that you are outside of the fence) or 1 to 4 points (meaning that you are
inside of the fence).

### Turning Polygons into Grids
So far, things have been pretty easy (although possibly not easy to follow
along the first time through) conceptually. Now you might have to get some
pin a paper out to draw this next piece to fully understand how we are
going to do this. 

Our objective is to turn a random, regular polygon into a set of grid-blocks
which estimate its shape. We're going to be using an algorithm similar to
how you get the [area of a polygon][5]. I'll give you the steps, then I'll
lay it out visually for you.

0. Create an array to contain your estimated polygon (array of grid-blocks),
we'll call it __E__
0. Generate a grid that contians your polygon
0. For each latitude (y-value on an x-y plane), draw a horizontal line
0. For each area in-between the horizontal lines:
    1. Get all grid-blocks that are between the lines, we'll call this list __G__
    1. Get all lines that intersect the horizontal-section, and for each one, called __l__:
        0. Get all grid-blocks in __G__ to the left of __l__, called __G<sub>2</sub>__
        0. For each grid-block in __G<sub>2</sub>__, called __g__:
            0. If __g__ is in __E__, remove __g__ from __E__
            0. If __g__ is not in __E__, add __g__ to __E__
0. Store grid-block center-points from __E__ in Mongo. Done!

<br />
If you didn't quite follow that (or can't visualize that well), then no
worries. Here is a visual:

![detailed estimation visualization 1][6]
![detailed estimation visualization 2][7]
![detailed estimation visualization 3][8]


# Coding Time

Okay, now that we have gone through evertyhing at the conceptual level, it's
time for some real code. If you had any trouble understanding the previous
sections, it will be worth your time to go back with pen and paper and draw
out all of the steps until it makes sense.

## Creating Our Grid

Assuming that we're going to get out polygon in the form of some Lat-Lon
points, then we can generate our grid like the following:

<script src="https://gist.github.com/3397316.js?file=grid-generation.rb"></script>


## Getting our Horizontal Sections

<script src="https://gist.github.com/3397316.js?file=get-horizontals.rb"></script>

Once we have our horizontal sections, we can then filter our grid-items to
only process those that are included in the sub-section. This would look
something like:

<script src="https://gist.github.com/3397316.js?file=get-sub-grids.rb"></script>


## Intersecting Lines

Alright! Now we just need to get the intersecting lines though the sub-grid
and we'll be one step away from adding grid-blocks into our estimated polygon
array. (If you don't know what I'm talking about, please review the conceptual
aproach, and visuals, above.)

<script src="https://gist.github.com/3397316.js?file=get-intersecting-lines.rb"></script>


## Is a Point to the Left or Right?

Now that we can get out intersecting lines, we need to determine, for each
point within the sub-grid, if that point is to the left of the intersecting
line or to the right of the line. If it is to the left of the line, then
two things can happen. If that point is already included in the 
estimated-polygon array, then it will be removed and if it was not in the
array, then it will be added. And finally, the code:

<script src="https://gist.github.com/3397316.js?file=det.rb"></script>



## Estimation Complete!

While it may not seem like you are done, trust me when I say you have
completed all of the necessary steps to estimate a geofence. The only
thing missing is to put all of the steps together (stay tuned). Now
that we have our estimation, we simply need to store it in Mongo.



## Mongo-Land

Okay, now that we have our estimated polygon/fence, it's time to store
those points in Mongo-land. First, we need to understand what our
resulting estimation looks like:

<script src="https://gist.github.com/3397316.js?file=estimated-fence-format.rb"></script>

The __:lon__ and __:lat__ would obviously be replaced with real values.
We're going to tranform this array of points to store in Mongo in the
following format:

<script src="https://gist.github.com/3397316.js?file=mongo-document.js"></script>

We have to use this particular format because it is required for us to
apply our geo-spatial index (which I'll show in a moment). If you want more
info on Mongo's geo-spatial indexes, check out [their docs][9].

To store our estimated polygon/fence into mongo, we're going to use the
following code:

<script src="https://gist.github.com/3397316.js?file=store-and-index.rb"></script>



## Querying Mongo

Now that we have everything stored in Mongo, it's time to utilize the DB's
geo-spatial indexing features to bring out geofences to life! And it's so
simple; the code is only:

<script src="https://gist.github.com/3397316.js?file=query-mongo.rb"></script>

Of course, I'm only returning if the count is greater than zero. You could
do whatever you please with the cursor. I think the cursor is nil if nothing
is found in Mongo, so you could just return the result of the find operation.




# Suprise!

It's time to find out what's at the end of the rainbow. I've been promising
_something_ this whole time. 

__TODO__ finish the post (p.s. - the surprise is the code, in case I forget)









  [1]: /log/2012/07/11/Geofencing--Part-1.md
  [2]: /blog-files/geofence/part-2/mongo-spatial-index-and-query.png
  [3]: /blog-files/geofence/part-2/polygon-estimation-conceptual.png
  [4]: /blog-files/geofence/part-2/polygon-query.png
  [5]: http://alienryderflex.com/polygon_area/
  [6]: /blog-files/geofence/part-2/polygon-estimation-detailed-1.png
  [7]: /blog-files/geofence/part-2/polygon-estimation-detailed-2.png
  [8]: /blog-files/geofence/part-2/polygon-estimation-detailed-3.png
  [9]: http://www.mongodb.org/display/DOCS/Geospatial+Indexing/
