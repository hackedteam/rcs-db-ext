require "spec_helper"

describe Optionable::Unknown do

  describe "#message" do

    let(:invalid) do
      described_class.new(:test, [ :first, :second ])
    end

    it "returns the valid names in the message" do
      expect(invalid.message).to eq(
        ":test is an unknown option. Valid options are: :first, :second."
      )
    end
  end
end
