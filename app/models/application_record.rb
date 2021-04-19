class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # belongs_to :picture, optional: true
  # belongs_to :user, optional: true
end
