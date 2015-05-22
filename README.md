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

tags.hidden
# => true

tags.each do |tag|
  puts tag
end
# => Master
# => Disabled
```

## Safe Chaining in Views

```ruby
resources = Container.new

# Product # 1000 = nil
resources.product = Product.where(id: 1000).first

resources.product.images.first.url
# => Container::NullObject
```

## NullObject

Collector::NullObject is a quick implementation of the [Null Object Pattern](http://en.wikipedia.org/wiki/Null_Object_pattern)

```ruby
null = Container::NullObject.new

null.nil?
# => true

null.blank?
# => true 

null.to_s
# => "" 

null.empty?
# => true 

!null
# => true

null.non_existent_field.non_existent_field
# => Container::NullObject
```

## Get Array and Hash values

```ruby
container = Container.new

container << 5
container << 3
container << 7

container[:a] = 3
container[:b] = 4
container.c = 5

container.array
# => [5, 3, 7]

container.hash
# => {:a=>3, :b=>4, :c=>5}

container.to_hash(:a, :b)
# => {:a=>3, :b=>4} 
```