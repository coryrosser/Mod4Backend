class User < ApplicationRecord
    has_many :projects, dependent: :destroy
    has_many :user_friends, dependent: :destroy
    has_many :friends, -> { where(user_friends: {accepted: true}) }, through: :user_friends
    has_many :pending_friends, -> { where(user_friends: {accepted: false}) }, through: :user_friends, source: :friend
    has_many :comments, dependent: :destroy
    has_many :commented_projects, through: :comments

    has_secure_password
    validates :username, uniqueness: true
end
