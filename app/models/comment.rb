class Comment < ApplicationRecord
  belongs_to :commenter, class_name: "User", foreign_key: 'user_id'
  belongs_to :commented_project, class_name: "Project", foreign_key: 'project_id'
end
