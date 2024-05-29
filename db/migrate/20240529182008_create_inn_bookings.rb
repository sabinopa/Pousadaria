class CreateInnBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :inn_bookings do |t|
      t.references :inn, null: false, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
