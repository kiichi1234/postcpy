class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :category, :body, presence: true
end
