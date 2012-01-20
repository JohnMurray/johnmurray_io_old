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
  * FnordMetric (v 0.6.3 is what I'm working with)

If you don't have a Linux server, then a VM or a free micro-instance from
Amazon will do just fine. For me, I'm justing using the free, default 64-bit
AMI from Amazon's official AMI list.

If you're entirely opposed to using Linux (and prefer Windows) then by all
means use it. However, you are on your own other than the brief mention that
you can find a great Windows Ruby installer over [here] [4].

Once you get the Linux server setup then you'll need to install Ruby. I'd
recommend (for ease) that you use [RVM] [3]. To get started, mosey on
over to their (entirely professional) site and follow the instructions. 

Once that is done, we need to install FnordMetric. This is my favorite part
just because it is so easy. Open up a terminal and run:

    gem install fnordmetric

That's it! Painless I know. :-)

## Your first Fnord

Now that we have everything setup, it's time to get down to business. 

### Starting First with Ruby
Open up your favorite editor and copy the following into `fnord.rb`

    ## fnord.rb
    require 'fnordmetric'
    
    FnordMetric.namespace :my_first_fnord do    
    
        # numeric gauge, shown on a per-hour total
        gauge :logins_per_hour,
            :tick  => 1.hour.to_i,
            :title => 'Logins per Hour'

        event(:login) { incr(:logins_per_hour) }
    
        widget 'Web Logins', {
          :title            => 'Web App Logins Per Hour',
          :type             => :timeline,
          :gauges           => :logins_per_hour,
          :include_current  => true,
          :autoupdate       => 2 #update graph every 2 seconds
        }
    end
    
    FnordMetric.standalone

That's all it takes to get a sample up and running. If you want proof, just run
the following in a terminal:

    ruby fnord.rb run

If everything is setup properly then you should be able to browse to
[http://localhost:4242/] [6] and see a dashboard similar to the following:

![FnordMetric Dashboard][8]

Yay, now that you have fnord running, you just need to pump in some data. But
fist, we need to stop and understand what all of this means. Let's take a look
at the first actual line of code:

<pre><code class="ruby">FnordMetric.namespace :my_first_fnord do</code></pre>

This simply let's us define a namespace within the Fnord application. What 
exactly is a namespace? Well, in the context of my work, it could be our web
application or our real time services. Think of it as the whole dashboard. Note
that it is possible to create multiple namespaces and host them all in one
Fnord instance. 

The next piece of important code is the gauge:

<pre><code class="ruby">gauge :logins_per_hour,
    :tick  => 1.hour.to_i,
    :title => 'Logins per Hour'
</code></pre>

This specifies the *bucket*, per say. This is a *bucket* (or gauge) where you
will store events. In this case I have a *bucket* (:logins_per_hour) that is
aggregated on a per-hourly basis and it titled 'Logins per Hour'. This means
that when I generate a graph, this data has a static granularity of a day. The
title is only used when looking at the keys in your graph.

Moving on, the event:

<pre><code class="ruby">event(:login) { incr(:logins_per_hour) }
</code></pre>

This registers the event that Fnord will listen to and what to do when that
event is received. In this case, we'd like to increment the gauge :logins_per_hour
when we receive a :login event. 

An event looks like this (in JSON):
<pre><code class="javascript">{ "_type": "login" }</code></pre>
This is sent to Fnord in a variety of ways (we'll look at one way in a minute).

Lastly, there is the widget. The widget determines what we're actually going
to show in the dashboard.
<pre><code class="ruby">
widget 'Web Logins', {
       :title            => 'Web App Logins Per Hour',
       :type             => :timeline,
       :gauges           => :logins_per_hour,
       :include_current  => true,
       :autoupdate       => 2 #update graph every 2 seconds
  }</code></pre>
In this case, we'd like to use the *bucket* (gauge) we've created as input to
a graph. We're saying that we'd like to create a timeline which includes the
current time and updates every two seconds (poll server for more data).We've
also given the widget a nice title to display.

<h3>Now Finishing with C#</h3>

Now that we understand how things work on the Fnord side of things, it's time
to crack open that C# project and get to work. The first thing that we need to
do is add a library reference (via NuGet) to [Sider] [7].

![Install Sider in Visual Studio via NuGet][9]

[Sider] [7] is a Redis library for C# that stays as close to the implementation
as possible. It doesn't deal with mapping complex data types to the underlying
storage engine. It's simple enough to be perfect for this demo. Remember earlier
when I said that events could come to Fnord in a variety of ways. Well, the way
we're going to send messages is to push messages directly to the Redis queue.
Fnord will notice the new message and process the event.

So, since the example I have given deals with tracking logins, you would
normally add the code below somewhere in your applications login method. Of
course you can follow along however you like (login or no login).

    using(var client = new RedisClient("linux.mysite.com:6379"))
    {
        String guid = Guid.NewGuid().ToString("N");
        String fnordId = String.Format("fnordmetric-event-{0}", guid)
        client.Set(fnordId, "{\"_type\": \"login\"}");
        client.Expire(fnordId, new TimeSpan(0, 0, 60));
        client.LPush("fnordmetric-queue", guid);
    }

At this point we are simply pushing a message directly to Redis. FnordMetric will
notice the event and update the results in the dashboard. Note that I have
set a timeout for this event of 60 seconds. This means that if FnordMetric is not
running, it could miss the event (Redis will expire it). However, this keeps us 
from quickly building up a lot of stale data in our Redis installation.

You might also notice that there are some conventions with how we are naming the
Redis keys. This is discussed in the next section if you are interested.


## Extra Goodness

 Okay, up until now, things have fit together pretty well without any
 intervention. But, what if my Redis install runs on a non-standard port? Or,
 perhaps I want my metrics dashboard to run over port 80 so that I can set
 up a sub-domain like stats.mysite.com. Maybe you're wondering how FnordMetric
 knows what items in Redis to read. Let's take a closer look. 

 The first piece of the puzzle is the configuration section which, if left
 out, is populated with some smart defaults. Let's define a custom
 configuration as

    ## fnord.rb

    # fnord namespace definition (as shown previously)

    FnordMetric.server_configuration = {
        # point to external redis on non-standard port
        redis_url:          'redis://10.1.0.38:6380',

        # prefix on events pushed to redis
        redis_prefix:       'mavia-metrics',

        # port on which to accept event-pushes (we're not using this)
        inbound_stream:     ['0.0.0.0', '1339'],

        # port to run web interface
        web_interface:      ['0.0.0.0', '80'],

        # worker "process" to watch redis (we want this)
        start_worker:       true,

        # make the program chatty so we know how it's feeling
        print_stats:        3,

        # events not processed after 2 minutes are dropped
        event_queue_ttl:    120,

        # event data is kept for one month
        event_data_ttl:     3600*24*30,

        # session data is kept for one month
        :session_data_ttl:  3600*24*30
          
    }

    FnordMetric.standalone

Take a minute to examine the configuration. Everything should be pretty
self-explanatory with the possible exception of the `redis_prefix`. This
is used to determine the keys you use when inserting data into redis. For
example, with the newly defined prefix, our redis ID might look like

<pre><code class="cs">String.Format("mavia-metrics-{0}", guid);</code></pre>

The one other item that might be a little confusing is the `inbound_stream`
configuration option. This specifies on what port the API will run. The API
is yet another way to push data to FnordMetric but, I'm not going to cover
that here. You can learn more about that on their [GitHub][1] page. 

Well, that's about it. There's not a lot of demystifying to do here. It's a
pretty straight forward project with a gorgeous API. Obviously there is a lot
more to this project than I have shown here. However, now that you have a
working setup to play with, I recommend heading over to the [GitHub] [1] page
to learn more interesting tricks! If making that extra mouse click is just
too much for you however, I've included a couple of extras below.


  [1]: http://github.com/paulasmuth/fnordmetric
  [2]: http://redis.io
  [3]: http://beginrescueend.com
  [4]: http://rubyinstaller.org/
  [5]: http://www.screenr.com/KiJs
  [6]: http://localhost:4242/
  [7]: http://github.com/chakrit/sider
  [8]: /blog-files/fnord-1.png
  [9]: /blog-files/fnord-2.png
