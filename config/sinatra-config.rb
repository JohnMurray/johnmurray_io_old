##----
## SINATRA SETTINGS
##   Settings that are more specific to Sinatra than anythign else
##----
set :environment, ENV["RACK_ENV"] ? ENV["RACK_ENV"].to_sym : :development
set :root, File.expand_path(File.join(File.dirname(__FILE__), '..'))
set :public, File.join(settings.root, 'public')
set :views, File.join(settings.root, 'views')
enable :static, :logging, :dump_errors
disable :sessions, :run
set :raise_errors, Proc.new { settings.environment == :development }
set :show_exceptions, Proc.new {settings.environment == :development }





##----
## LOGGING SETTINGS
##   Settings that have to do with logging in general
##----
set :logdir, File.join(settings.root, 'log')
