require 'pry'
require 'support/base'

RSpec.describe ControllableVersioning do
  before :each do
    Support::Base.init_or_refresh_data
  end

  it "has a version number" do
    expect(ControllableVersioning::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(Original.first.id).to eq Original.first.id
  end
end
