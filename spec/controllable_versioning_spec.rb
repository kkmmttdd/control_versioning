require 'pry'
require 'support/base'
require_relative 'spec_utils'

RSpec.describe ControllableVersioning do
  it "has a version number" do
    expect(ControllableVersioning::VERSION).not_to be nil
  end

  before :context do
    Support::Base.init_or_refresh_data
  end

  describe "#InstanceMethods::version!" do
    context "default case" do
      let(:original_record) { Original.first}
      let(:copied_record) { original_record.version!}
      it "copies expected model" do
        expect(copied_record.class.name).to eq "Copied"
      end

      it "copies expected columns" do
        expect(copied_record.name).to eq "original name"
        expect(copied_record.attendance_on).to eq Date.new(2020, 1, 1)
        expect(copied_record.price).to eq 1000
      end

      it "copies expected instance methods" do
        expect(copied_record.price_with_tax).to eq 1100
      end

      it "excluded columns specified by user" do
        expect(copied_record.do_not_want_to_copy).to eq nil
      end

      it "copied has original instance id" do
        expect(copied_record.originated_model_id).to eq 1
      end

      it "copied has original instance model" do
        expect(copied_record.originated_model_name).to eq "Original"
      end
    end

    context "controlled case(and default false)" do
      let(:original_record) { ControlledOriginal.first}
      let(:copied_record) { original_record.version!}
      it "copies expected model" do
        expect(copied_record.class.name).to eq "ControlledCopied"
      end

      it "copies expected columns" do
        expect(copied_record.foo_bar_name).to eq "controlled original name"
        expect(copied_record.foo_bar_attendance_on).to eq Date.new(2021, 1, 1)
        expect(copied_record.foo_bar_price).to eq 2000
      end

      it "not copied columns not specified by user" do
        expect(copied_record.name).to eq nil
      end

      it "copies expected instance methods" do
        expect(copied_record.foo_bar_price_with_tax).to eq 2200
      end

      it "copied has original instance id" do
        expect(copied_record.originated_model_id).to eq 1
      end

      it "copied has original instance model" do
        expect(copied_record.originated_model_name).to eq "ControlledOriginal"
      end
    end
  end

end
