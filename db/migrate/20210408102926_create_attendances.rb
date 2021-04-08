class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
    	t.references :user, foreign_key: true
    	t.date :attendace_date
    	t.boolean :present, default: false
    	t.time :temperature_time
    	t.float :temperature, precision: 5, scale: 2
      	t.timestamps
    end
  end
end
