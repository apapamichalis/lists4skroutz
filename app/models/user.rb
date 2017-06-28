class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 8..128
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true

  has_many :lists, dependent: :destroy
  has_many :votes, dependent: :destroy

  def likes?(list)
    list.votes.where(user_id: id).any?
  end
end
