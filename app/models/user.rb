class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :posts, dependent: :destroy #アソシエーション設定。ユーザーモデルから投稿モデルを検索できるようにする。
  has_many :comments, dependent: :destroy
  has_many :blocked_users, class_name: 'Block', foreign_key: :blocked_id, dependent: :destroy
  has_many :blockers, class_name: 'Block', foreign_key: :blocker_id, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
