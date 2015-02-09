require "spec_helper"

describe Optionable::Invalid do

  describe "#message" do

    context "when a single value is provided" do

      let(:invalid) do
        described_class.new(:test, 10, [ 15 ])
      end

      it "returns the single value error message" do
        expect(invalid.message).to eq(
          "10 is not acceptable for option :test. Valid values are: 15."
        )
      end
    end

    context "when multiple values are provided" do

      let(:invalid) do
        described_class.new(:test, 10, [ 15, "something" ])
      end

      it "returns the single value error message" do
        expect(invalid.message).to eq(
          "10 is not acceptable for option :test. Valid values are: 15, \"something\"."
        )
      end
    end

    context "when multiple values are provided with type" do

      let(:invalid) do
        described_class.new(:test, "test", [ Optionable.any(Integer) ])
      end

      it "returns the single value error message" do
        expect(invalid.message).to eq(
          "\"test\" is not acceptable for option :test. Valid values are: any Integer."
        )
      end
    end
  end
end
