require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = companies(:one)

    @original_per_page = Company.per_page
    Company.per_page = 3 # Set custom per_age attribute
  end

  teardown do
    Company.per_page = @original_per_page # Reset to original value
  end

  test 'should have many deals' do
    assert_not_empty @company.deals
    assert @company.deals.all? { |deal| deal.is_a?(Deal) }
  end

  test 'should paginate companies and return correct size' do
    first_page_companies = Company.paginate(page: 1)
    assert_equal 3, first_page_companies.size, 'First page should have 3 companies'
  end

  test "#with_minimum_deal_amount scope does not include companies with lower deal amount" do
    companies = Company.with_minimum_deal_amount(@company.total_deals_amount + 1)

    refute_includes companies, companies(:one)
  end

  test '#total_deals_amount should calculate the total deal amount' do
    assert_equal 400, @company.total_deals_amount
  end
end
