class QueryValidator 


	def initialize (query)
		@query = query

	end

	def validate

		@query.text = putTableTag(@query.text)
		 @query.databases.each do |db|	

		 	@query.text.gsub! '[DATABASE].',db.name + '.'
		

		 	sqlObj = SQLData.new(db.machine.user,db.machine.passwd,db.machine.hostname, "EXPLAIN PLAN FOR " + @query.text)
		 	begin
		 		sqlObj.exec_sql_statement

		 	rescue Exception => e
		 		@query.errors[:base] << db.name + " Error : " + e.message + "; statement that fails : " + @query.text + "on machine : " + db.machine.name

		 	end

		 	@query.text.gsub! db.name + '.', '[DATABASE].'
		 
		 end
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