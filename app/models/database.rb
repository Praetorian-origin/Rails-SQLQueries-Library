class Database < ApplicationRecord
	belongs_to :machine
	has_many :database_query_assignments
	has_many :queries, through: :database_query_assignments


		validates :machine, presence: true
         validates  :name, presence: true
end
