class Project < ApplicationRecord
  include Abyme::Model
  
  has_many :tasks, inverse_of: :project, dependent: :destroy
  has_many :comments, through: :tasks
  
  abyme_for :tasks

  validates :title, presence: true
  validates :description, presence: true
end
