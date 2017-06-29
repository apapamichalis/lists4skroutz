class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :list, :counter_cache => true
end
