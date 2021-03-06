# NoConditionals

Conditional statements, like if/else, have it's place, under libraries and frameworks, but not in application code. This library implements a collection of techniques to avoid if/else, initially by extending "Truthy" and "Falsey" classes with expressive yet Ruby idiomatic operations. Please look forward for more features to come.

## Getting started

Make sure you have Ruby 2.1 or above, and then add this line to your application's Gemfile:

```ruby
gem 'no_conditionals'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install no_conditionals


## Monkey patching Rails application
This library uses refinement to extend objects. Alternatively, you may also do the following:

Save this code to the Rails application folder as 'config/initializers/no_conditionals.rb'.
```ruby
# config/initializers/no_conditionals.rb

Object.class_eval do
  include NoConditionals::Truthiness
end

NilClass.class_eval do
  include NoConditionals::Falseyness
end

FalseClass.class_eval do
  include NoConditionals::Falseyness
end
```
And then restart the server.

## Usage

### #hence method
Evaluates block if "Truthy" otherwise returns "Falsey"
```ruby
using NoConditionals

true.hence { "Yes" } # => "Yes"

false.hence { "Yes" } # => false

nil.hence { "Yes" } # => nil

[1,2,3,4,5].find {|n| n.odd? }.hence {|odd| "found #{odd}" } # => "found 1"

["", "Ruby", "Smalltalk", nil ].first.hence(&:empty?) # => true
```
### #otherwise method
Returns self if "Truthy" otherwise evaluates block.
```ruby
using NoConditionals

true.otherwise { "No" } # => true

false.otherwise { "No" } # => "No"

nil.otherwise { "No" } # => "No"
```
### #maybe method
Returns first argument if "Truthy". If "Falsey" it either returns second argument or returns "Falsey" when only one argument.
```ruby
using NoConditionals

(3 > 2).maybe "Yes", maybe: "No" # => "Yes"

(1 > 2).maybe "Yes", maybe: "No" # => "No"

true.maybe "Yes" # => "Yes"

false.maybe "Yes" # => false

nil.maybe "Yes" # => nil
```

### #maybe! method
Calls first argument if "Truthy". If "Falsey" it either calls second argument or calls nothing when only one argument.
```ruby
using NoConditionals

(3 > 2).maybe! -> { puts "True" }, maybe: -> { puts "False" } # True

(1 > 2).maybe! -> { puts "True" }, maybe: -> { puts "False" } # False

true.maybe! -> { puts "True" } # True

false.maybe! -> { puts "True" } # => false

nil.maybe! -> { puts "True" } # => nil
```

## Sample codes

### Replacing if-else conditions in controllers
```ruby
class SessionsController
  ...
  using NoConditionals

  def create
    user = User.find_by_email params[:email]
    user
      .authenticate(params[:password])
      .hence { logged_in(user) }
      .otherwise { unauthenticated }
  end
  ...
end
```

### Extending models and null objects
```ruby
class User
  include NoConditionals::Truthiness
  ...
end

class MissingUser
  include NoConditionals::Falseyness
  ...
end
```

### Replacing Object#try() in Rails application views
```erb
<%= @article.author.hence(&:name).otherwise { "Anonymous" } %>

<%= current_user
      .hence(&:admin?)
      .hence { link_to 'Edit, edit_article_path(@article) }
      .otherwise { 'Read Only' } %>
```
### Chaining methods
```ruby
class WeatherService
  using NoConditionals

  def weather_for(report)
     report
       .hence( &:source )
       .hence( &:location )
       .hence( &:city )
       .hence( &:weather )
       .otherwise { 'unknown weather' }
  end
end
```

## Contributing

1. Fork it ( https://github.com/RichOrElse/no-conditionals/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
