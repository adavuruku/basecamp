class Project < ApplicationRecord
    has_many :project_thread
    has_many :project_attached
    has_many :project_task
    #self.primary_key = "projectid"
    validates :title, presence: true
    validates :description, presence: true
    validates :userid, presence: true
    validates :projectid, presence: true, uniqueness:true
    validates :status, presence: true
end
