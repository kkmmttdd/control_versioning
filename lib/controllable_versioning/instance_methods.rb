module ControllableVersioning
  module InstanceMethods

    def version!
      ActiveRecord::Base.transaction do
        self.save!
        self.class.target_model.create!(versioned_attrs)
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
    def versioned_attrs
      attrs = self.class.versioned_column_hash.map do |original_column, copied_column|
        [copied_column, self[original_column]]
      end.to_h
      attrs.merge!({:originated_model_id => self.id})
      attrs.merge!({:originated_model_name => self.class.name})
      attrs
    end

  end
end