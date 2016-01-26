require 'minitest_helper'

describe NoConditionals::Truthiness do
  before do
    @truthy = Object.new.extend NoConditionals::Truthiness
  end

  describe "#hence" do
    it "evaluates a block" do
      @truthy.hence { :yes }.must_be_same_as :yes
      @truthy.hence { |truthy| truthy }.must_be_same_as @truthy
    end
  end

  describe "#otherwise" do
    it "just returns itself" do
      @truthy.otherwise { :no }.must_be_same_as @truthy
      @truthy.otherwise { |truthy| :no }.must_be_same_as @truthy
    end
  end

  describe "#maybe" do
    it "just returns first argument" do
      @truthy.maybe(:yes).must_be_same_as :yes
      @truthy.maybe(:yes, maybe: :no).must_be_same_as :yes
    end

    it "raises error for wrong keyword argument" do
      -> { @truthy.maybe :yes, otherwise: :no }.must_raise ArgumentError
    end
  end

  describe "#maybe!" do
    it "calls first argument" do
      @truthy.maybe!(-> { :yes }).must_be_same_as :yes
      @truthy.maybe!(-> { :yes }, maybe: -> { :no }).must_be_same_as :yes
    end

    it "raises error for wrong keyword argument" do
      -> { @truthy.maybe! -> { :yes }, otherwise: -> { :no } }.must_raise ArgumentError
    end
  end
end
