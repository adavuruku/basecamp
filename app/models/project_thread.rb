class ProjectThread < ApplicationRecord
  belongs_to :project
  has_many:thread_message, class_name: "ThreadMessage"
  validates :description, presence: true
  validates :project_id, presence: true
end