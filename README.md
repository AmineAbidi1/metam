# Metam

Metam is a gem that extends a Model with dynamic attributes and validators during runtime.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metam'
```

And then execute:

```ruby
$ bundle
```

## Usage

Example: for a User model:
```ruby
# encoding: utf-8

require 'metam'

class User < ActiveRecord::Base

  # Serialize the metadata in order to be stored in the database
  serialize :metadata, Hash
  
  # Building the metamodel for the user object
  metamodel scope: ->(user) { user.affiliation }, store: :metadata

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
