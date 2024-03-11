require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = companies(:one)
  end

  test 'should have many deals' do
    assert_not_empty @company.deals
    assert @company.deals.all? { |deal| deal.is_a?(Deal) }
  end
end
