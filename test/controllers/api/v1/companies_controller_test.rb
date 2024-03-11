require 'test_helper'

class Api::V1::CompaniesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company1 = companies(:one)
    @company2 = companies(:two)
  end

  test "should get index" do
    get api_v1_companies_url
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['companies']
  end

  class FilterTests < Api::V1::CompaniesControllerTest
    test "should filter companies by name" do
      get api_v1_companies_url, params: { companyName: @company1.name }
      assert_response :success

      json_response = JSON.parse(response.body)
      assert_equal 1, json_response['companies'].length
      assert_equal @company1.name, json_response['companies'].first['name']
    end

    test "should filter companies by industry" do
      get api_v1_companies_url, params: { industry: @company1.industry }
      assert_response :success

      json_response = JSON.parse(response.body)
      companies = json_response['companies']
      assert companies.any? { |company| company['industry'] == @company1.industry }
    end

    test "should filter companies by min employee count" do
      get api_v1_companies_url, params: { minEmployee: @company1.employee_count }
      assert_response :success

      json_response = JSON.parse(response.body)
      assert_not_empty json_response['companies']
      json_response['companies'].each do |company|
        assert_operator company['employee_count'], :>=, @company1.employee_count
      end
    end

    test "should filter companies by minimum deal amount" do
      deal1 = deals(:one)
      deal2 = deals(:two)
      company_with_deal1 = deal1.company
      company_with_deal2 = deal2.company

      get api_v1_companies_url, params: { minimumDealAmount: deal1.amount + 1 }
      assert_response :success

      json_response = JSON.parse(response.body)
      assert_equal 1, json_response['companies'].length
      assert_equal company_with_deal2.id, json_response['companies'].first['id']
    end
  end

  private

  def api_v1_companies_url
    "/api/v1/companies"
  end
end
