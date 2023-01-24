class Particular < ApplicationRecord
  include Discard::Model
  
  belongs_to :invoice
  has_paper_trail

  validates :amount, presence:true
end
