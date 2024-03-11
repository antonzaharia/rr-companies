class Company < ApplicationRecord
  self.per_page = 10
  include Filterer

  has_many :deals

  scope :order_by_creation_desc, -> { order(created_at: :desc) }
  scope :with_total_deals_amount, -> {
    joins(:deals)
      .group(:id)
      .select("companies.*, SUM(deals.amount) AS total_deals_amount")
  }
  scope :with_minimum_deal_amount, ->(min_amount) {
    joins(:deals)
      .group('companies.id')
      .having('SUM(deals.amount) >= ?', min_amount)
  }

  def self.filtered_and_paginated(params)
    with_total_deals_amount
      .filtered(params.except(:page))
      .order_by_creation_desc
      .paginate(page: params[:page])
  end

  def total_deals_amount
    self.read_attribute(:total_deals_amount) || deals.sum(:amount)
  end
end
