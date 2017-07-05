class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true

  has_many :lists, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followee_id",
                                   dependent:   :destroy


  has_many :followees, through: :active_relationships, source: :followee
  has_many :followers, through: :passive_relationships, source: :follower


  def likes?(list)
    list.votes.where(user_id: id).any?
  end

  # Follows a user.
  def follow(other_user)
    followees << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    followees.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    followees.include?(other_user)
  end


end
