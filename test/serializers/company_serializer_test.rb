require 'test_helper'

class CompanySerializerTest < ActiveSupport::TestCase
  def setup
    @company = companies(:one)
    @serializer = CompanySerializer.new(@company)
  end

  test 'serializes id' do
    assert_equal @company.id, @serializer.serializable_hash[:id]
  end

  test 'serializes name' do
    assert_equal @company.name, @serializer.serializable_hash[:name]
  end

  test 'serializes industry' do
    assert_equal @company.industry, @serializer.serializable_hash[:industry]
  end

  test 'serializes employee_count' do
    assert_equal @company.employee_count, @serializer.serializable_hash[:employee_count]
  end

  test 'calculates total deals amount' do
    expected_total = @company.deals.sum(&:amount)
    assert_equal expected_total, @serializer.total_deals_amount
  end
end
