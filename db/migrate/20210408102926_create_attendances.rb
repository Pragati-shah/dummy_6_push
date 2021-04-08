class CreateAttendances < ActiveRecord::Migration[6.1]
  def up
    create_table :attendances do |t|
    	t.references :user, foreign_key: true
    	t.date :attendace_date
    	t.boolean :present_for_day, default: false
    	t.time :temperature_time
    	t.float :temperature, precision: 5, scale: 2
      	t.timestamps
    end
  end
  def down
    drop_table :attendances
    	
  end
end
