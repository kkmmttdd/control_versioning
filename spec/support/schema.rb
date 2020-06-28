module Support
  module Schema
    def self.init_or_refresh_schema
      ActiveRecord::Schema.define do
        self.verbose = false

        create_table :originals, force: true do |t|
          t.string :name
          t.date :attendance_on
          t.integer :price
          t.string :do_not_want_to_copy
        end

        create_table :controlled_originals, force: true do |t|
          t.string :name
          t.date :attendance_on
          t.integer :price
        end

        create_table :copieds, force: true do |t|
          t.string :originated_model_name
          t.integer :originated_model_id
          t.string :name
          t.date :attendance_on
          t.integer :price
          t.integer :price_with_tax
          t.string :do_not_want_to_copy
        end

        create_table :controlled_copieds, force: true do |t|
          t.string :originated_model_name
          t.integer :originated_model_id
          t.string :name
          t.string :foo_bar_name
          t.date :foo_bar_attendance_on
          t.integer :foo_bar_price
          t.integer :foo_bar_price_with_tax
        end
      end
    end
  end
end
