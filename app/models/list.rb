class List < ApplicationRecord

  has_many :votes,        dependent: :destroy
  has_many :listproducts, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end

end
