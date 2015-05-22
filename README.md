# Container.rb
Handy Ruby object container for cleaner views

## Installation

Container is available as a RubyGem:

```bash
$ gem install container
```

## Basic Usage

Container serves as an array and hash at the same time

```ruby
tags = Container.new

tags << "Master"
tags << "Disabled"

tags.hidden = true

tags.hidden?
# => true
```