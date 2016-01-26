require 'minitest_helper'

class TestNoConditionals < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::NoConditionals::VERSION
  end

  using NoConditionals

  def test_it_refines_truthy_types
    [ [], {}, "", 100, 0.5, 1..20, true, (3 > 2) ].each do |truthy|
      assert_equal 'Yes', truthy.maybe!(-> {'Yes'})
      assert_equal 'Yes', truthy.maybe!(-> {'Yes'}, maybe: -> {'No'})
      assert_equal 'Yes', truthy.maybe('Yes')
      assert_equal 'Yes', truthy.maybe('Yes', maybe: 'No')
      assert_equal 'Yes', truthy.hence { 'Yes' }
      assert_equal truthy, truthy.otherwise { 'No' }
    end
  end

  def test_it_refines_falsey_types
    [ nil, false, (1 > 2)].each do |flsy|
      assert_equal nil, flsy.maybe!(-> {'Yes'})
      assert_equal 'No', flsy.maybe!(-> {'Yes'}, maybe: -> {'No'})
      assert_equal flsy, flsy.maybe('Yes')
      assert_equal 'No', flsy.maybe('Yes', maybe: 'No')
      assert_equal flsy, flsy.hence { 'Yes' }
      assert_equal 'No', flsy.otherwise { 'No' }
    end
  end
end
