

class SQLDataThreads
	
	# variables de tableaux pour export_preview
	
	def initialize (query)
		@query = query
		
		@array_columns = Array.new()
		@array_of_conns = Array.new()
		@hash_of_data = Hash.new {|h, k| h[k] =[]}
		
	end
	
	
	
	def getSQLData #mode dans le paramètre, preview, explain, etc...
		threads = []
		@array_columns = @query.text[/#{"SELECT"}(.*?)#{"FROM"}/m, 1].split(',')
		
		
		@query.machines.each do |machine|
			# initialiser les connexions pour chacune des machines
			
			
			
			
			threads << Thread.new {
			@array_of_conns.push([machine.id, OCI8.new(machine.user,machine.passwd,machine.hostname)])
			
			puts "one thread started"
			#conn = OCI8.new(machine.user,machine.passwd, machine.hostname)
			# pour chaque BDD sélectionné	
			dbs = Database.where("databases.id IN (?) AND databases.id IN (?)", @query.databases.ids, machine.databases.ids)
			
			
			
			
			dbs.each do |db|
				@hash_of_data[db.name] = []
			end
			
			
			# # récupérer les données
			dbs.each do |db| 
				puts "START: " + db.name
				data_array = Array.new()
				conn = nil
				
				statement = @query.text.gsub '[DATABASE]', db.name
			
				@array_of_conns.each do |sub_array|
					if sub_array[0] = db.machine_id
						
						conn = sub_array[1]
						
					end
					
				end
				
				cursor = conn.parse(statement)
				array = []
				begin 
					cursor.exec
					cursor.fetch() {|row|
					@hash_of_data[db.name] << Array.new(row)
					data_array.push(Array.new(row))
					
				}
		
				puts statement + " :: " + db.name + " :: " + conn.hostname.to_s
				raise exception
			end
			cursor.close
			puts "END: " + db.name
		end
		
		
	}
	
end 
threads.each(&:join)

@query.databases.each do |database|
	
	workbook = FastExcel.open(filename = database.name + '.xlsx', constant_memory: true)
	
	workbook.default_format.set(
	font_size: 0, # user's default
	font_family: "Arial",
	bold: true
	)
	
	worksheet = workbook.add_worksheet
	
	worksheet.auto_width = true
	
	worksheet.append_row(@array_columns)
	
	
	
	@hash_of_data[database.name].each do |sub_array|
		sub_array.map! { |x| x || ""}
		worksheet.append_row(sub_array)
		
	end
	workbook.close 
	
	
end


zip_file_name = @query.title + '.zip'

Zip::File.open(zip_file_name, Zip::File::CREATE) do |zipfile|
	@query.databases.each do |filename|
		# Two arguments:
		# - The name of the file as it will appear in the archive
		# - The original file, including the path to find it
		zipfile.add(filename.name + '.xlsx', File.join(Dir.pwd, filename.name + '.xlsx'))
	end
end

@query.databases.each do |filename|
	File.delete(filename.name + '.xlsx')
end

return zip_file_name


end





end



