module ControllableVersioning
  module ClassMethods
    def control_versioning
      p "from control_versioning"
      yield
    end
  end
end