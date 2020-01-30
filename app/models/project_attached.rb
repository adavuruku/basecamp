class ProjectAttached < ApplicationRecord
  belongs_to :project
  has_many_attached :images
  validates :images, presence: true, on: :create
  validates :comment, presence: true
  validates :userid, presence: true, on: :create
  validates :project_id, presence: true , on: :create
end