class Machine < ApplicationRecord
	has_many :databases
	has_many :database_query_assignments, through: :databases
	has_many :queries, through: :database_query_assignments

	
end
