In school, there is quite a bit of discussion on shortest-path type 
algorithms. However, have you ever thought about how you would solve
that problem given physical objects?

Let's assume that you have a bunch of marbles. Each marble represents a node.
The marbles (nodes) are connected by some type of string. The length of the
string is equal to it's weight (the longer the string, the higher the weight).
Let's also assume that the graph is sufficiently complex that simply "seeing"
the shortest path is fairly unlikely. 

How would you solve the problem? Would you just look over the graph to see
if you can _"spot"_ the shortest path (brute force)? Would you be tempted 
to use Dijkstra's algorithm? Some other graph algorithm?

I was thinking about this on my way into work this morning and realized that
given the physical objects, you simply pick up the two nodes you're interested
in finding a path between and pull them apart. The first path to become taunt
is your shortest path. It's so simple and straightforward. It's intuitive and
accessible by all; regardless of background, education, or age. 

That brief thought left me wondering if there are algorithms out there for
graphs, that take this intuitive approach? _(I'm not sure if there is or not,
I'm just rambling I suppose.)_
