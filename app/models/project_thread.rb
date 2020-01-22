class ProjectThread < ApplicationRecord
  belongs_to :project
  has_many:thread_message, class_name: "ThreadMessage"
end