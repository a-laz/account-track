class CreateDeliveries < ActiveRecord::Migration[7.0]
  def change
    create_table :deliveries do |t|
      t.string :zipcode
      t.string :customer_name
      t.datetime :date
      t.string :type

      t.timestamps
    end
  end
end
