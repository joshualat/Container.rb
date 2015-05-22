# Container.rb
Handy Ruby object container for cleaner views

## Installation

Container is available as a RubyGem:

```bash
$ gem install container
```

## Basic Usage: Container

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

## Basic Usage: NullObject

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

## Advanced Usage: NullObject

Existing variables may be wrapped using the NullObject.wrap method to allow chaining without fear of NoMethodError concerns in views

```ruby
class Cow
  def moo
    puts "moo!"
  end
end

cow = Cow.new
cow.moo
# => "moo!"

cow = Container::NullObject.wrap(cow)
cow.bark
# => Container::NullObject

cow.owner.name
# => Container::NullObject

puts "Something" + Container::NullObject.new + "Hidden"
# => "SomethingHidden"
```

## Custom Containers

```ruby
class Chain < Container
  def render
    @array.join('-')
  end
end

chain << 5
chain << 3
chain << 7
chain << 8
 
chain.render
# => "5-3-7-8" 
```

License
-------
Copyright (c) 2015 Joshua Arvin Lat

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.