class List < ApplicationRecord

  belongs_to :user
  has_many :votes
  has_many :listproducts

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
