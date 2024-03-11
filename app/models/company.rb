class Company < ApplicationRecord
  include Filterer

  has_many :deals

  def self.filtered_companies(params)
    includes(:deals)
      .filtered(params.except(:page))
      .order(created_at: :desc)
  end
end
