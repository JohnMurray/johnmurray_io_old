class JMApp < Sinatra::Base
  ##----
  ## static contact page with my email address on it (encoded of
  ## course).
  ##----
  get '/contact' do
    haml :contact
  end
end
