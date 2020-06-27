module Support
  module Schema
    def self.init_or_create_tables
      ActiveRecord::Schema.define do
        self.verbose = false

        create_table :originals, force: true do |t|
          t.string :name
          t.date :attendance_on
        end

        create_table :copieds, force: true do |t|
          t.string :originated_model_name
          t.integer :originated_model_id
          t.string :name
          t.string :customize_name
          t.date :attendance_on
        end
      end
    end
  end
end
