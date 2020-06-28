module ControllableVersioning
  module InstanceMethods

    def version!
      ActiveRecord::Base.transaction do
        self.save!
        Copied.create!(versioned_attrs)
      end
    end

    def restore_version!

    end

    def restore_last!

    end

    def latest_version

    end

    def versions

    end


    # private
    def user_defined_column_hash
      {}
    end


    def default_column_hash
      columns = self.class.column_names - %w(id created_at updated_at)
      columns.map do |col|
        [col, col]
      end.to_h
    end

    def versioned_column_hash(default=true)
      target_hash = {}
      target_hash.merge!(default_column_hash) if default
      target_hash.merge!(user_defined_column_hash)
    end

    def versioned_attrs
      attrs = versioned_column_hash.map do |original_column, copied_column|
        [copied_column, self[original_column]]
      end.to_h
      attrs.merge!({:originated_model_id => self.id})
      attrs.merge!({:originated_model_name => self.class.name})
      attrs
    end

  end
end