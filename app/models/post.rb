class Post < ApplicationRecord
  belongs_to :user #投稿モデルからユーザーモデルを検索できるようにする設定。＊user_idのカラムを追加する必要がある
  has_many :comments, dependent: :destroy
  validates :category, :body, presence: true
end
