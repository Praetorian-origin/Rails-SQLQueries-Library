class DatabaseQueryAssignment < ApplicationRecord
  belongs_to :database
  belongs_to :query
end
