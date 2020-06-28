module ControllableVersioning
  module InstanceMethods

    def version!(dynamic_attr={})
      ActiveRecord::Base.transaction do
        self.save!
        attr = versioned_attrs
        attr.merge! dynamic_attr
        self.class.target_model.create!(attr)
      end
    end

    def restore_version!(version)
      self.update!(restore_attrs(version))
    end

    def versions
      self.class.target_model.where({originated_model_id: self.id, originated_model_name: self.class.name})
    end

    private
    def versioned_attrs
      attrs = self.class.versioned_column_hash.map do |original_column, copied_column|
        [copied_column, self.send(original_column)]
      end.to_h
      attrs.merge!({:originated_model_id => self.id})
      attrs.merge!({:originated_model_name => self.class.name})
      attrs
    end

    def restore_attrs(version)
      accepted_column_names = self.class.column_names.map(&:to_sym)
      attrs = self.class.versioned_column_hash.map do |original_column, copied_column|
        next unless accepted_column_names.include?(original_column)
        [original_column, version.send(copied_column)]
      end.compact.to_h
    end
  end
end