class Company < ApplicationRecord
  include Filterer

  has_many :deals
end
