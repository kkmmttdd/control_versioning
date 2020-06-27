module Support
  module Data
    def self.execute
      Original.create!(
          name: "original name",
          attendance_on: Date.new(2020, 1, 1)
      )
    end
  end
end
