class Project < ApplicationRecord
  
  has_many :tasks, inverse_of: :project, dependent: :destroy
  has_many :comments, through: :tasks
  
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
end
