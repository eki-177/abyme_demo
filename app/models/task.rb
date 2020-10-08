class Task < ApplicationRecord
  # include Abyme::Abymize

  belongs_to :project
  has_many :comments, inverse_of: :task, dependent: :destroy

  # abyme_for :comments
  accepts_nested_attributes_for :comments, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true

  scope :done, -> { where(status: 'done') }
  scope :todo, -> { where(status: 'todo') }
end

