require 'minitest/autorun'
require 'container'

class ContainerTest < Minitest::Test
  def test_array_properties
    tags = Container.new

    tags << "Master"
    tags << "Disabled"

    assert_equal tags.array, ["Master", "Disabled"]
  end

  def test_hash_properties
    tags = Container.new
    tags.hidden = true
    tags.version = 1.5
    tags.label = "primary"

    assert_equal tags.hidden?, true
    assert_equal tags.hidden, true
    assert_equal tags[:hidden], true
    assert_equal tags.to_hash(:hidden), {:hidden => true}
    assert_equal tags.to_hash(:hidden, :version), 
      {:hidden => true, :version => 1.5}
  end

  def test_safe_chaining_in_views
    resources = Container.new
    resources.product = nil

    assert_instance_of Container::NullObject, 
      resources.product.images.first.url
  end

  def test_null_object_properties
    null = Container::NullObject.new

    assert_equal null.nil?, true
    assert_equal null.blank?, true
    assert_equal null.to_s, ""
    assert_equal null.empty?, true
    assert_equal !null, true
    assert_instance_of Container::NullObject,
      null.non_existent_field.non_existent_field
  end

  def test_alternate_syntax_for_container
    row = Container.new

    row.set('optional note') do |r|
      r.master = true
      r.disabled = false
      r.id = 5
    end

    assert_equal row.master?, true
    assert_equal row.disabled?, false
    assert_equal row.id, 5
  end

  class Cow
    def moo
      "moo!"
    end
  end

  def test_advanced_usage_for_null_object
    cow = Cow.new
    assert_equal cow.moo, "moo!"

    cow = Container::NullObject.wrap(cow)
    assert_instance_of Container::NullObject, cow.bark
    assert_instance_of Container::NullObject, cow.owner.name

    assert_equal "Something" + Container::NullObject.new + "Hidden",
      "SomethingHidden"
  end

  class Chain < Container
    def render
      @array.join('-')
    end
  end

  def test_custom_containers
    chain = Chain.new

    chain << 5
    chain << 3
    chain << 7
    chain << 8

    chain.render
  end
end