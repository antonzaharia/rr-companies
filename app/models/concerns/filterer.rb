module Filterer
  extend ActiveSupport::Concern

  class_methods do
    # Using Chain of Responsibility design pattern
    def filtered(params)
      results = self.where(nil) # Creates an anonymous scope

      filters_chain = [
        method(:filter_by_name),
        method(:filter_by_industry),
        method(:filter_by_min_employee_count),
        method(:filter_by_minimum_deal_total_amount)
      ]

      filters_chain.each do |filter|
        results = filter.call(results, params)
      end

      results
    end

    private

    # Filtering by company name
    def filter_by_name(results, params)
      return results unless params[:companyName].present?

      results.where("companies.name LIKE ?", "%#{params[:companyName]}%")
    end

    # Filtering by industry
    def filter_by_industry(results, params)
      return results unless params[:industry].present?

      results.where("companies.industry LIKE ?", "%#{params[:industry]}%")
    end

    # Filtering by min employee count
    def filter_by_min_employee_count(results, params)
      return results unless params[:minEmployee].present?

      results.where("companies.employee_count >= ?", params[:minEmployee])
    end

    # Filtering by min deal total amount
    def filter_by_minimum_deal_total_amount(results, params)
      return results unless params[:minimumDealAmount].present?

      results.with_minimum_deal_amount(params[:minimumDealAmount])
    end
  end
end
