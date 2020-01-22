class ThreadMessage < ApplicationRecord
    belongs_to :project_thread, class_name: "ProjectThread", optional: true

end
