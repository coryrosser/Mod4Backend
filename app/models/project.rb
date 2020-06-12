class Project < ApplicationRecord
    has_many :pictures, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :commenters, through: :comments
    belongs_to :user
end
