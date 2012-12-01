require 'test_helper'

class TestTemplate < ActiveSupport::TestCase

  def test_render_template_with_variables
    value = 'test'
    template = Template.new('/test/fixtures/templates/test.html')
    template.add_variables({:variable => value})
    assert_equal "some text #{value} another text", @template.render
  end

end