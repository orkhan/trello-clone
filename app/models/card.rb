class Card < ApplicationRecord
  validaes :title, presence: true
  
  belongs_to :list
end
