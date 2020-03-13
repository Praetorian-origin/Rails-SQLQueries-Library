class Test

	def initialize

	end
	def getit

		connexion= OCI8.new('DURIEZ','aCe37E','10.30.252.174:1521/ABYLA')
		array_num_comp_bat = []

		cursor = connexion.parse("SELECT num_comp_bat FROM abysni_rct.ikos_patrim WHERE date_suppr is NULL")
		array = []
		cursor.exec
		cursor.fetch() {|row|
			array_num_comp_bat.push(row)

		}




		array_num_comp_bat.each do |row|
			item.each do |item|
				cursor = connexion.parse("SELECT oga FROM abysni_rct.ikos_patrim WHERE date_suppr is NULL and num_comp_bat =" + item)
				array = []
				cursor.exec
				cursor.fetch() {|row|
					array_num_comp_bat.push(row)
					
				}
				cursor.close
			end
		end

		connexion.close



	end

end

