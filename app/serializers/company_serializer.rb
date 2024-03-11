class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :industry, :employee_count, :total_deals_amount

  def total_deals_amount
    object.deals.sum(&:amount)
  end
end
