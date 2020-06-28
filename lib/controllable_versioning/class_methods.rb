module ControllableVersioning
  module ClassMethods
    def self.extended(klass)
      klass.class_eval do
        @default = true
        @user_defined_column_hash = {}
        @excluded_columns = []
      end
    end

    def control_versioning
      yield
    end

    def target_model
      @target_model
    end

    def versioned_column_hash
      target_hash = {}
      target_hash.merge!(default_column_hash) if @default
      target_hash.merge!(@user_defined_column_hash)
      target_hash
    end

    private
    def default_column_hash
      default_excluded_columns = %i(id created_at updated_at originated_model_id originated_model_name)
      columns = self.target_model.column_names.map(&:to_sym) - default_excluded_columns - @excluded_columns
      columns.map do |col|
        [col, col]
      end.to_h
    end


    def target(target_model)
      @target_model = target_model
    end

    def default(is_default=true)
      @default = is_default
    end

    def versioning_columns(target_hash)
      @user_defined_column_hash = target_hash if target_hash
    end

    def exclude(excluded_columns)
      @excluded_columns = excluded_columns
    end
  end
end