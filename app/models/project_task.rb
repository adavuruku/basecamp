class ProjectTask < ApplicationRecord
  belongs_to :project
  validates :description, presence: true
  validates :project_id, presence: true, on: :create
  validates :userid, presence: true, on: :create
end