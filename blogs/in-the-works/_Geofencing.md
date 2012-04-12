**tl;dr**

#Abridged Summary (for those who don't read)
You can represent geofences in MongoDB as a series of points. To start, you
place your polygon on a grid and then use an area-estimation problem to see
which grid-blocks lie within the polygon (checking the center-points of the
blocks). You then take these blocks and get the center points for each block. 
We can then store these center-points into their own collection in MongoDB 
and apply a geo-spatial index. ([illustrative images below][1])

Now, all we need to do is query the collection with a nearby query with a
radius of **[sqrt(2)*l] / 2 + a** where **l** is the length of the grid-block
(assuming it's a square) and a is some very small fudge factor. If you want
to know more of how or why this works, then you'll have to read the longer
version below. I know it's long, skim if you think that helps.


#tl;dr Version




  [1]: #grid_images
