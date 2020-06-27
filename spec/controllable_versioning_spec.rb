require 'pry'
require 'support/base'
require_relative 'spec_utils'

RSpec.describe ControllableVersioning do
  before :context do
    Support::Base.init_or_refresh_data
  end

  it "has a version number" do
    expect(ControllableVersioning::VERSION).not_to be nil
  end

  context "default case" do
    let(:original_record) { Original.first}
    let(:copied_record) { original_record.version!}
    it "version! copies expected model" do
      expect(copied_record.class.name).to eq "Copied"
    end

    it "version! copies expected columns" do
      expect(copied_record.name).to eq "original name"
      expect(copied_record.attendance_on).to eq Date.new(2020, 1, 1)
    end

    it "copied has original instance id" do
      expect(copied_record.originated_model_id).to eq 1
    end

    it "copied has original instance model" do
      expect(copied_record.originated_model_name).to eq "Original"
    end
  end
end
