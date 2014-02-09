# johnmurray.io

This code-base represents my personal blog [johnmurray.io][1]. However, it is freely
available for you to re-use (to build your own blog site presumably) if you so choose.

The site is a standard [Sinatra][2] site with one exception. The site had now database
and renders Markdown files (using the RDiscount gem). Memcache is also used along with
standard HTTP cache headers to make this processes very lightweight. I deploy this site
to Heroku (as-is) and so that should be no problem. 

Feel free to email me if you have any questions or requests at me at johnmurray dot io.




  [1]: http://www.johnmurray.io
  [2]: http://sinatrarb.com
