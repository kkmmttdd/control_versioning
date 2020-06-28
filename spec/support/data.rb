module Support
  module Data
    def self.execute
      Original.create!(
          name: "original name",
          attendance_on: Date.new(2020, 1, 1),
          price: 1000
      )
      ControlledOriginal.create!(
          name: "controlled original name",
          attendance_on: Date.new(2021, 1, 1),
          price: 2000
      )
    end
  end
end
