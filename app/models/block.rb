class Block < ApplicationRecord
  belongs_to :blocked_user, class_name: 'User', foreign_key: :blocked_id
  belongs_to :blocker_user, class_name: 'User', foreign_key: :blocker_id
end
