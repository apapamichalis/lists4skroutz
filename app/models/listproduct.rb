class Listproduct < ApplicationRecord

  belongs_to :list

  validates :list_id, presence: true, uniqueness: { scope: :skuid }
  validates :skuid, presence: true, uniqueness: {scope: :list_id}
end
