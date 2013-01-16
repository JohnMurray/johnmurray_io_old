So, my classes are over and the results are in. I've implemented a solution
to the [Metric k-center][1] problem and, to be honest, the results are not all
that interesting. But, I'll go ahead and answer the questions that I proposed
in my last post.

### What will the solution look like?

The solution was composed of two parts, the runner and the viewer. Its
important to solve the problem (obviously) it is also important to visualize
you're results. While it is easy to calculate metrics on how much your
algorithm improves over a random solution, it's hard to see where improvements
can be made (or how they could be made). 

The runner is targetted for JRuby and solves the application in parallel by
solving for the various values of _k_. The output is then persisted to a MySQL
database so that the logs can later be analyzed and rendered (by the viewer).

The viewer is just a simple Sinatra app that queries the DB for the latest runs
and allows you to pick out a specific generation for a particular run and value
of _k_ and the results are rendered using the [Raphael JS][2] library. 

### What approaches will be best utilized for solving/estimating the problem?

By approaches I don't mean frameworks or technologies, I am more referring to
algorithms. For this, I chose to use a couple of different approaches and
combine them together. The first is a [genetic algorithmm][3] (GA) and the 
second is the [Wisdom of the Crowd][4] (WoC). 

The GA allows me to derive
solutions rather quickly from an initial, random set of solutions (read
up on the Wikipedia article if you need more information on GAs) but, like all
solutions to NP-C problems it is merely an estimation to the solution. WoC allows us
generate a consensus from the set of _experts_ (top performing members) of a
given population of solutions. 

These two approaches will be the main driving factor for our runner. 

### How fast is it? (because all we care about is speed)

While I don't have exact metrics, it takes about 32 seconds to solve a
problem for 100 nodes for 80 value of _k_ and 500 evolutions. That's running
on my home desktop. 

Now, while I don't have exact metrics I can talk a little bit about JRuby
versus MRI Ruby. My choice to go with JRuby is two-fold. The first reason
is that I get the benefit of _real_-threading. By this I mean that there is
no GIL and when I run multiple threads, I get the benefit of JVM threads
(running on multiple cores). This means that I can use libraries like
[peach][5]. The second is faster overall runtime of the runner (regardless
of whether or not threads are used). 

Since these computations can be ran in parallel and since I have a quad-core
machine, it only makes sense to run the tasks in parallel across multiple cores.
However, if you're a Rubyist, then you should be more than familiar with the
limitations that come along with the GIL. From this, we can see why JRuby, in
this circumstance, is a much better choice than the current MRI release. 

### What makes my solution better than other existing solutions?

Nothing really. There's not much novel about my solution, but it was fun and
I did suffice to learn quite a bit. I've posted the code (for anyone interested)
on GitHub at [JohnMurray/metric-k-center.git][6]. I've also added a writeup
of the project (PDF) that is included in the repository if you're inclined
to know a little more about it.


  [1]: https://en.wikipedia.org/wiki/Metric_k-center
  [2]: http://raphaeljs.com/
  [3]: https://en.wikipedia.org/wiki/Genetic_algorithm
  [4]: https://en.wikipedia.org/wiki/The_Wisdom_of_Crowds
  [5]: http://peach.rubyforge.org/
  [6]: https://github.com/JohnMurray/metric-k-center
