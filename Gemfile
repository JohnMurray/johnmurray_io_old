source 'https://rubygems.org'

ruby '2.1.0'

# You'll notice that there are no versions in here. That's
# on purpose so that I know that I am staying up to date
# with the latest gems and keeping me on my toes. If something
# breaks, it's not a big deal because it's just my personal
# blog.... meh.
group :development, :production do
  gem 'builder',        '~> 3.2.2'
  gem 'dalli',          '~> 2.7.0'
  gem 'haml',           '~> 4.0.5'
  gem 'kgio',           '~> 2.8.1'    # dalli performance boost
  gem 'rdiscount',      '~> 2.1.7'
  gem 'rack',           '~> 1.5.2'
  gem 'sinatra',        '~> 1.4.4'
end


group :production do
  gem 'thin',           '~> 1.6.1'
end


group :development do
  gem 'pry'
  gem 'shotgun'
end
