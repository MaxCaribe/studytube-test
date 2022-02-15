class Stock < ApplicationRecord
  acts_as_paranoid

  belongs_to :bearer

  validates :name, presence: true, uniqueness: true
end
