# Abridged Version
You can represent a geofence as a series of square blocks. These square blocks
represent an estimation of your fence (which we'll think about as a standard
n-gon polygon).
Using the center-points for each of these blocks, we can store the estimated
polygon in Mongo as an array of coordinate pairs. We can then use some of
Mongo's built-in query features to determine if a coordinate lies within (or
outside of) the polygon. Viola, geofencing with Mongo. If I've peaked your
interest (and you have the time), please read the full version.

# tl;dr Version
The rest of the document will go as follows:

+ [What is a Geofence?][1] <sub>a general rundown</sub>
+ [Polygons and Grids][2] <sub>a little bit o'math</sub>
+ [Grids and Mongo][3] <sub>storing conceptual grids in Mongo</sub>
+ [Boundary Crossing][4] <sub>mixing in some practicality</sub>
+ [Putting it All Together][5] <sub>let's make something useful</sub>
+ [Better Options?][6] <sub>any ideas?</sub>


## What is a Geofence?
talk about what a geofence is
explain it to the laymen

## Polygons and Grids
talk about representing polygons as grids. This is where we're
going to get into a little bit of math (area estimation problems
and what not)

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
Invite everyone to email me their options or write-up their response
and tweet at me. 

<sub>Just an example of what Gists will look like in my post</sub>
<script src="https://gist.github.com/2418105.js?file=User.rb">
</script>

<script src="https://gist.github.com/1869025.js?file=load-keyboard">
</script>




  [1]: #what_is_a_geofence
  [2]: #polygons_and_grids
  [3]: #grids_and_mongo
  [4]: #boundary_crossing
  [5]: #putting_it_all_together
  [6]: #better_options
