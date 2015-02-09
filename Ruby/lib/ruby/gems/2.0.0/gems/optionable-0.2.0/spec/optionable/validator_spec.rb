require "spec_helper"

describe Optionable::Validator do

  describe "#allow" do

    let(:validator) do
      described_class.new(:test)
    end

    let(:allowed) do
      validator.send(:allowed_values)
    end

    context "when no values exist" do

      before do
        validator.allow(:test)
      end

      it "sets the valid options" do
        expect(allowed).to eq([ :test ])
      end
    end

    context "when sending multiple values" do

      before do
        validator.allow(:test, :testing)
      end

      it "sets the valid options" do
        expect(allowed).to eq([ :test, :testing ])
      end
    end

    context "when existing values are present" do

      before do
        validator.allow(:test)
        validator.allow(:testing)
      end

      it "sets the valid options" do
        expect(allowed).to eq([ :test, :testing ])
      end
    end
  end

  describe "#initialize" do

    let(:validator) do
      described_class.new(:test)
    end

    it "sets the key of the option" do
      expect(validator.key).to eq(:test)
    end
  end

  describe "#validate!" do

    let(:validator) do
      described_class.new(:test)
    end

    context "when the value is acceptable" do

      before do
        validator.allow(:testing)
      end

      it "raises no error" do
        expect {
          validator.validate!(:testing)
        }.to_not raise_error
      end
    end

    context "when the value is invalid" do

      it "raises an error" do
        expect {
          validator.validate!(:testing)
        }.to raise_error(Optionable::Invalid)
      end
    end
  end
end
