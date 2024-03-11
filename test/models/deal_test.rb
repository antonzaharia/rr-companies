require 'test_helper'

class DealTest < ActiveSupport::TestCase
  def setup
    @deal = deals(:one)
  end

  test 'should belong to company' do
    assert_not_nil @deal.company, 'Deal does not have a company associated with it'
  end
end
