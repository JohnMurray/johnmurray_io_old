
class JMApp < Sinatra::Base
  ##----
  ## Set the cache-control for Varnish to cache the pages in my
  ## Heroku App
  ## 
  ## Configure default notes to show at top of page.
  ##----
  before do
    cache_control :public, :max_age => 7200
    @notes = ""
  end


  ##----
  ## Try to pull data out of the cache. If the item is not found
  ## in cache, then return the result from the block passed in.
  ##----
  def with_cache(cache_key, &block)
    result = @cache.get(cache_key)

    unless result
      result = block.call
      @cache.set(cache_key, result)
      STDERR.puts("Cache set for #{cache_key}")
    end

    result
  end
end
