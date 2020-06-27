require 'controllable_versioning'

class Original < ActiveRecord::Base
  include ControllableVersioning
  control_versioning do
    def override_sample_method
      "override succeeded!!"
    end
  end

end

class Copied < ActiveRecord::Base
end

