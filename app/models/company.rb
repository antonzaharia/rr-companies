class Company < ApplicationRecord
  self.per_page = 10
  include Filterer

  has_many :deals

  scope :order_by_creation_desc, -> { order(created_at: :desc) }

  def self.filtered_companies(params)
    includes(:deals)
      .filtered(params.except(:page))
      .order_by_creation_desc
      .paginate(page: params[:page])
  end
end
