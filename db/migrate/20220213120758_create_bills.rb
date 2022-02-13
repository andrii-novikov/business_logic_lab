class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.date :from
      t.date :till
      t.bigint :zone_1_from
      t.bigint :zone_2_from
      t.bigint :zone_1_till
      t.bigint :zone_2_till
      t.bigint :zone_1
      t.bigint :zone_2
      t.bigint :total
      t.bigint :tariff
      t.bigint :zone_1_amount
      t.bigint :zone_2_amount
      t.bigint :total_amount

      t.timestamps
    end
  end
end
