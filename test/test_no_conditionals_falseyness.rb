require 'minitest_helper'

describe NoConditionals::Falseyness do
  before do
    @falsey = Object.new.extend NoConditionals::Falseyness
  end

  describe "#hence" do
    it "just returns itself" do
      @falsey.hence { :yes }.must_be_same_as @falsey
      @falsey.hence { |falsey| :yes }.must_be_same_as @falsey
    end
  end

  describe "#otherwise" do
    it "evaluates block" do
      @falsey.otherwise { :no }.must_be_same_as :no
      @falsey.otherwise { |falsey| falsey }.must_be_same_as @falsey
    end
  end

  describe "#maybe with one argument" do
    it "returns itself" do
      @falsey.maybe(:yes).must_be_same_as @falsey
    end
  end

  describe "#maybe with two arguments" do
    it "returns last argument" do
      @falsey.maybe(:yes, maybe: :no).must_be_same_as :no
    end

    it "raises error for wrong keyword argument" do
      -> { @falsey.maybe :yes, otherwise: :no }.must_raise ArgumentError
    end
  end

  describe "#maybe! with one argument" do
    it "calls nothing, returns itself" do
      @falsey.maybe!(-> { :yes }).must_be_same_as @falsey
    end
  end

  describe "#maybe! with two arguments" do
    it "calls last argument" do
      @falsey.maybe!(-> { :yes }, maybe: -> { :no }).must_be_same_as :no
    end

    it "raises error for wrong keyword argument" do
      -> { @falsey.maybe! -> { :yes }, otherwise: -> { :no } }.must_raise ArgumentError
    end
  end
end
