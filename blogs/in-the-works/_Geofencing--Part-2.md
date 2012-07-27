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











  [1]: /log/2012/07/11/Geofencing--Part-1.md
  [2]: /blog-files/geofence/part-2/mongo-spatial-index-and-query.png
  [3]: /blog-files/geofence/part-2/polygon-estimation-conceptual.png
  [4]: /blog-files/geofence/part-2/polygon-query.png
