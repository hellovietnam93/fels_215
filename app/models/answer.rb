class Answer < ApplicationRecord
  belongs_to :word, optional: true
  
  has_many :results
  has_many :lessons, through: :results
end
