class CreateMachines < ActiveRecord::Migration[6.0]
  def change
    create_table :machines do |t|
      t.string :name, null:false
      t.string :hostname, null:false
      t.string :user, null:false
      t.string :passwd, null:false
      t.string :description

      t.timestamps
    end
  end
end
