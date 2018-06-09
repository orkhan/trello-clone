class Board < ApplicationRecord
  include Uniqueable

  validates :name, presence: true
  validates :uid, uniqueness: true

  has_many :lists
end
