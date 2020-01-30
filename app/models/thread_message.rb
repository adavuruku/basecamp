class ThreadMessage < ApplicationRecord
    belongs_to :project_thread, class_name: "ProjectThread", optional: true
    validates :project_thread_id, presence: true,  on: :create
    validates :message, presence: true
    validates :userid, presence: true,  on: :create
end
