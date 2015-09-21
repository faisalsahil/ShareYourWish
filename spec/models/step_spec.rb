require 'spec_helper'

describe Step do
  before(:each) do
    @saved = Step.first
  end

  it "can be instantiated" do
    @saved.should be_an_instance_of(Step)
  end

  it "can be saved successfully" do
    @saved.should be_persisted
  end

  it "should be valid" do
    @saved.should be_valid
  end

  it "shouldn't be saved without :title" do
    @saved.should validate_presence_of(:title)
  end

  it "shouldn't be saved with :title length not in 2..255" do
    @saved.should ensure_length_of(:title).is_at_least(2).is_at_most(255)
  end

  it "shouldn't be saved without :description" do
    @saved.should validate_presence_of(:description)
  end

  it "shouldn't be saved with :description length not :minimum 2" do
    @saved.should ensure_length_of(:description).is_at_least(2)
  end

  it "shouldn't be saved without :order" do
    @saved.should validate_presence_of(:order)
  end

  it "shouldn't be saved with :order non numerical" do
    @saved.should validate_numericality_of(:order)
  end

  it "shouldn't be saved with :order not in 0..99" do
    @saved.should ensure_inclusion_of(:order).in_range(0..99)
  end

end