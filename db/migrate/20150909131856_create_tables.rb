class CreateTables < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :student_number
      t.string :school_year
      t.integer :payment_method # Full or Installment
      t.integer :year_level
      t.decimal :balance
      t.integer :tuition_fee_id
      # Personal Information
      t.string :guardian_name
      t.integer :contact_number
      t.text :present_address
      t.timestamps
    end

    create_table :tuition_fees do |t|
      t.integer :year_level
      t.decimal :tuition_fees
      t.decimal :misc_fees
      t.decimal :other_fees
      t.decimal :upon_enrollment
      t.integer :payment_type # Annual - Semestrail - Quarterly - LDP
      t.timestamps
    end

    create_table :payments do |t|
      t.integer :student_number
      t.string :referrence_number
      t.boolean :discounted 
      t.decimal :discount_amount # can be null
      t.decimal :amount_paid
      t.datetime :date_paid
      t.timestamps
    end
  end
end
