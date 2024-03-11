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
        method(:filter_by_minimum_deal_amount)
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

      results.where("name LIKE ?", "%#{params[:companyName]}%")
    end

    # Filtering by industry
    def filter_by_industry(results, params)
      return results unless params[:industry].present?

      results.where("industry LIKE ?", "%#{params[:industry]}%")
    end

    # Filtering by min employee count
    def filter_by_min_employee_count(results, params)
      return results unless params[:minEmployee].present?

      results.where("employee_count >= ?", params[:minEmployee])
    end

    # Filtering by min deal amount
    def filter_by_minimum_deal_amount(results, params)
      return results unless params[:minimumDealAmount].present?

      ids = Deal.where('amount >= ?', params[:minimumDealAmount]).distinct.pluck(:company_id)
      results.where(id: ids)
    end
  end
end
