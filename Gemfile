source 'https://rubygems.org'

# pushing to heroku may cause an error if we don't specify ruby version which is used by heroku. Check it by "heroku version" command
ruby '2.2.1'
gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sprockets', '~> 3.4'
gem 'carrierwave' , '~> 0.10.0'
gem 'mini_magick' , '~> 3.8.0'
#We'll use these 2 gems for pagination
gem 'will_paginate', '~> 3.0.7'
gem 'bootstrap-will_paginate', '~>0.0.10'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

#we want to make specific gems to be used for testing enviroment & development enviroment. So we'll make a group for them.
group :development, :test do
  gem 'sqlite3'
  #We use this gem to show the passed parameters when a link is clicked. Just type "BINDING.PRY" inside the action you want to test. NOTE: this will put you server on halt then in 
  #in the console type "PARAMS" to see the passed parameters
  gem 'pry'
end

#Heroku uses Postgres Database. So we make a production group and we will put postgres DB inside it. Also we can add other gems inside this group.
group :prodution do 
  gem 'pg'
  gem 'rails_12factor'
end