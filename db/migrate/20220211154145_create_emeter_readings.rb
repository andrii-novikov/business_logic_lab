class CreateEmeterReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :emeter_readings do |t|
      t.date :date
      t.bigint :zone_1
      t.bigint :zone_2
      t.integer :source_type

      t.timestamps
    end
  end
end
