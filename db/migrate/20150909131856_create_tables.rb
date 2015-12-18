class CreateTables < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :extension_name
      t.string :student_number
      t.string :school_year_id
      t.integer :payment_method # Cash or Installment
      t.integer :year_level_id
      t.integer :payment_terms_id # Payment Terms if not cash
      t.integer :tuition_fee_id
      # Personal Information
      t.string :guardian_name
      t.string :guardian_relationship
      t.integer :contact_number1, :limit => 8
      t.integer :contact_number2, :limit => 8
      t.integer :contact_number3, :limit => 8
      t.text :present_address
      t.integer :gender
      t.datetime :birth_date
      t.integer :status
      t.timestamps
    end

    # Tuition Fees 
    create_table :tuition_fees do |t|
      t.integer :student_id
      t.string :student_number
      t.integer :cash_basis_fee_id
      t.integer :installment_basis_fee_id
      t.string :due_of_payment_ids, array: true, default: []
      t.decimal :balance
      t.timestamps
    end

    create_table :cash_basis_fees do |t|
      t.integer :school_year_id
      t.integer :year_level_id
      t.decimal :tuition_fee
      t.decimal :miscellaneous
      t.decimal :other_fee
      t.decimal :total_fee
      t.timestamps
    end

    create_table :installment_basis_fees do |t|
      t.integer :school_year_id
      t.integer :year_level_id
      t.integer :payment_terms # [Monthly / Quarterly / Semi-Annual]
      t.decimal :tuition_fee
      t.decimal :down_payment
      t.decimal :other_fee
      t.timestamps
    end

    create_table :due_of_payments do |t|
      t.integer :installment_basis_fee_id
      t.string :due_date
      t.decimal :amount
      t.timestamps
    end

    create_table :payments do |t|
      t.string :student_number
      t.integer :school_year_id # In payment of
      t.integer :year_level_id # Level
      t.integer :payment_mode # Cash or Installment
      t.integer :payment_terms # Monthly Semi A.
      t.string :referrence_number
      t.integer :pay_id # [School Uniform, PE Uniform, School Supplies or Tuition Fee]
      t.string :description
      t.integer :first_discount_id # can be null
      t.integer :two_discount_id # can be null
      t.integer :third_discount_id # can be null
      t.decimal :amount_paid
      t.decimal :penalty, :default => 0.0
      t.datetime :date_paid
      t.string :received_by
      t.timestamps
    end

    create_table :discounts do |t|
      t.string :name
      t.decimal :percentage
      t.text :reason
      t.timestamps
    end

    create_table :school_uniforms do |t|
      t.integer :school_year_id
      t.integer :level
      t.integer :gender
      t.string :uniform_size
      t.decimal :amount
      t.timestamps
    end

    create_table :pe_uniforms do |t|
      t.string :uniform_size
      t.decimal :amount
      t.integer :uniform_type # T-Shirt or Jogging Pants
      t.timestamps
    end

    create_table :school_supplies do |t|
      t.string :name
      t.decimal :amount
      t.timestamps
    end

    create_table :employees do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :role_id
      t.datetime :date_hired
      t.timestamps
    end

    create_table :school_years do |t|
      t.string :name
      t.timestamps
    end

    create_table :year_levels do |t|
      t.string :name
    end
  end
end
