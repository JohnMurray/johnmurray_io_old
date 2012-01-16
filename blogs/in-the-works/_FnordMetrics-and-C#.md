# What's a Fnord?
So, if you've taken a look at FnordMetrics then you know why it's worth
trying out. It's easy to get setup, has a great API for defining your
metrics collection, and is a powerful tool in your platform-analytics
arsenal. 

If you've never heard of FnordMetrics before (since it's relatively new at
this point) then, let me explain a little bit. From the FnordMetric site, it
says:

> _FnordMetric is a highly configurable (and pretty fast) realtime app/event 
> tracking thing based on ruby eventmachine and redis. You define your own 
> plotting and counting functions as ruby blocks!_

This pretty much sums it up. It's a beautiful API for representing data in
a very compelling and useful way. If you want to know more about the project, 
head on over to their [GitHub] [1] page. Also, be sure to check out the
[original screencast] [5] to see it in action!


# On To the Show
Okay, let's get down to business. I'm going to walk you through getting started
with FnordMetric in your C# project. Why C# you may ask? Well, mainly because
that is the environment which I am currently spending my time in (at work) and 
because I believe we can all benefit from great projects. Not just _cool_ 
startups who _don't_ use .NET.

## Getting Started

To follow along, you're going to need the following:

* A .NET project to play with
* A Linux server with:
  * A Ruby installation (>= v1.9.2)
  * A [Redis] [2] installation (I'm using 2.4.6)

If you don't have a Linux server, then a VM or a free micro-instance from
Amazon will do just fine. For me, I'm justing using the free, default 64-bit
AMI from Amazon's official AMI list.

> _If you're entirely opposed to using Linux (and prefer Windows) then by all
> means use it. However, you are on your own other than the brief mention that
> you can find a great Windows Ruby installer over [here] [4]._

Once you get the Linux server setup then you'll need to install Ruby. I'd
recommend (for ease) that you use [RVM] [3]. To get started, mosey on
over to their (entirely professional) site and follow the instructions. Once
you get RVM installed you can run:

    rvm install ruby-1.9.2-p290

Once that is done, we need to install FnordMetric. This is my favorite part
just because it is so easy. In the same terminal that you might have ran the
previous command, run:

    gem install fnordmetric

That's it! Painless I know. :-)

## Your first Fnord

Now that we have everything setup, it's time to get down to business. Open up
your favorite editor and copy the following into `fnord.rb`

    ## fnord.rb
    require 'fnordmetric'
    
    FnordMetric.namespace :my_first_fnord do    
    
        # numeric gauge, shown on a per-hour total
        gauge :logins_per_hour,
            :tick  => 1.hour.to_i,
            :title => 'Logins per Hour'

        event :login do
            incr :logins_per_hour
        end
    
        widget 'Web Logins', {
          :title            => 'Web App Logins Per Hour',
          :type             => :timeline,
          :gauges           => :logins_per_hour,
          :include_current  => true,
          :autoupdate       => 2 #update graph every 2 seconds
        }
    end
    
    FnordMetric.standalone

A quick note, I am currently assuming that you have created this file on the
Linux server to which you installed redis. If not, just keep reading and I'll
fill you in on how to get it running. If so however, run the following command
to start the project

    ruby fnord.rb run

If everything is setup properly then you should be able to browse to
[http://localhost:4242/] [6] and see a dashboard similar to the following:

**TODO: insert image of dashboard**


  [1]: http://github.com/paulasmuth/fnordmetric
  [2]: http://redis.io
  [3]: http://http://beginrescueend.com
  [4]: http://rubyinstaller.org/
  [5]: http://www.screenr.com/KiJs
  [6]: http://localhost:4242/
