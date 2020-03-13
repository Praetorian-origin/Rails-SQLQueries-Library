class Query < ApplicationRecord
	has_many :database_query_assignments,  dependent: :destroy
	has_many :databases, through: :database_query_assignments
	has_many :machines, through: :databases

	validates :title, presence: true
	validates :text, presence: true
	validates :databases, presence: true
	


	validate do |query|
		QueryValidator.new(query).validate
	end

	
	before_save do
		self.text = upperSQLKeyWords(self.text)
		self.text = putTableTag(self.text)

	end





	def upperSQLKeyWords(str1)

		str2 = ["select ", " from ", " where "," join "," on "," delete "," union ",
			" minus "," exists "," not ", " in ", "delete ", "update "]

			str2.each do |keyWord|
				str1.gsub! keyWord, keyWord.upcase
			end

			puts str1
			return str1
		end


		def putTableTag (str1)
			database_array = Array.new() 
			str2 = Database.all.collect 

			str2.each do |str|
				database_array.push(str.name)
			end


			database_array.each do |keyWord|
				keyWord = keyWord.downcase
				str1.gsub! keyWord, keyWord.upcase
			end


			database_array.each do |database| 
				str1.gsub! database + '.', "[DATABASE]."
			end
			return str1

		end




	end


