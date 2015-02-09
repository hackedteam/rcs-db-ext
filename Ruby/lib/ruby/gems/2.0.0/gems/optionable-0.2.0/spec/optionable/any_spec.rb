require "spec_helper"

describe Optionable::Any do

  describe "#==" do

    let(:any) do
      described_class.new(Integer)
    end

    context "when the value is of the correct type" do

      it "returns true" do
        expect(any).to eq(10)
      end
    end

    context "when the value is an incorrect type" do

      it "returns false" do
        expect(any).to_not eq(10.5)
      end
    end
  end

  describe "#initialize" do

    let(:any) do
      described_class.new(Integer)
    end

    it "sets the type" do
      expect(any.type).to eq(Integer)
    end
  end

  describe "#inspect" do

    let(:any) do
      described_class.new(Integer)
    end

    it "returns any + the name of the class" do
      expect(any.inspect).to eq("any Integer")
    end
  end
end
