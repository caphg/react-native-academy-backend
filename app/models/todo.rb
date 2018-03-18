class Todo < ActiveRecord::Base
  belongs_to :user

  validates :user_id,
            :title,
            presence: true

  scope :for_user, ->(user) { where(user_id: user.id) }

  has_many :contacts

  accepts_nested_attributes_for :contacts, :allow_destroy => true
end
