require 'test_helper'

class FilterTest < ActiveSupport::TestCase
  setup do
    @company = companies(:one)
  end

  test 'filter by name' do
    params = { companyName: @company.name }
    filtered = Company.filtered(params)

    assert_equal filtered.count, Company.where("name LIKE ?", "%#{params[:companyName]}%").count
    filtered.each do |company|
      assert company.name.include?(params[:companyName]), "Company #{company.id} does not match the filter criteria"
    end
  end

  test 'filter by industry' do
    params = { industry: @company.industry }
    filtered = Company.filtered(params)

    assert_equal filtered.count, Company.where("industry LIKE ?", "%#{params[:industry]}%").count
    filtered.each do |company|
      assert company.industry.include?(params[:industry]), "Company #{company.id} does not match the filter criteria"
    end
  end

  test 'filter by min employee count' do
    params = { minEmployee: @company.employee_count }
    filtered = Company.filtered(params)

    assert_equal filtered.count, Company.where("employee_count >= ?", params[:minEmployee]).count
    filtered.each do |company|
      assert company.employee_count >= params[:minEmployee], "Company #{company.id} does not match the filter criteria"
    end
  end

  test 'filter by minimum deal amount' do
    params = { minimumDealAmount: 100 }
    filtered = Company.filtered(params)

    filtered_ids = filtered.pluck(:id)
    expected_ids = Deal.where('amount >= ?', params[:minimumDealAmount]).distinct.pluck(:company_id)

    assert_equal filtered_ids.sort, expected_ids.sort
    assert filtered_ids.all? { |id| expected_ids.include?(id) }, "Filtered companies do not match expected companies with deals above the minimum amount"
  end
end
