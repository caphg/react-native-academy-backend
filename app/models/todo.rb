class Todo < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :title,
            presence: true

  has_many :contacts

  accepts_nested_attributes_for :contacts, :allow_destroy => true
end
