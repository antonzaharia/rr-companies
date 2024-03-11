class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :industry, :employee_count, :total_deals_amount

  def total_deals_amount
    object.total_deals_amount
  end
end
