module SpecUtils
  def self.default_copied_columns(model_instance)
    model_instance.class.column_names - %w(id created_at updated_at)
  end
end