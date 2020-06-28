require 'controllable_versioning'

class Copied < ActiveRecord::Base
end

class ControlledCopied < ActiveRecord::Base
end

class Original < ActiveRecord::Base
  include ControllableVersioning
  control_versioning do
    target Copied
    exclude [:do_not_want_to_copy]
  end

  def price_with_tax
    (price * 1.1).to_i
  end
end

class ControlledOriginal < ActiveRecord::Base
  include ControllableVersioning
  control_versioning do
    target ControlledCopied
    default false
    versioning_columns({
          name: :foo_bar_name,
          attendance_on: :foo_bar_attendance_on,
          price: :foo_bar_price,
          price_with_tax: :foo_bar_price_with_tax,
    })

    def price_with_tax
      (price * 1.1).to_i
    end
  end

end


