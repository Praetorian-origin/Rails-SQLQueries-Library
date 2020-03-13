class SQLData


	def initialize(username, passwd, hostname, statement)
		@username = username
		@passwd = passwd 
		@hostname  = hostname
		@statement = statement
		OCI8.properties[:tcp_connect_timeout] = 10
		OCI8.properties[:connect_timeout] = 15

	end

	def get_sql_data (preview)
		@conn = OCI8.new(@username,@passwd,@hostname)
	

		if preview == true 
		  if @statement.include? "WHERE"  # prévoir que après le where il peut y avoir autre chose... group by, having, order by
		  	@statement << ' AND ROWNUM < 10'
		  else
		  	@statement << ' WHERE ROWNUM < 10'
		  end
		end 
			

		  @cursor = @conn.parse(@statement)
		  @array = []
		  @cursor.exec
		  @cursor.fetch() {|row|

		  	@array.push(Array.new(row))
		  }

		  @cursor.close
		  @conn.logoff
		  return @array
		end

		def exec_sql_statement
			@conn = OCI8.new(@username,@passwd,@hostname)	
			@cursor = @conn.parse(@statement)
			@cursor.exec
			@cursor.close
			@conn.logoff
		end




		def get_sql_columns
			@statement[/#{"SELECT"}(.*?)#{"FROM"}/m, 1].split(',')
		end


	end
