# encoding: UTF-8
require 'spec_helper'

describe Tag do
  describe "validate" do
    subject { FactoryGirl.build :tag }
    it { should be_valid }
    it { should have_many(:taggings) }
    it { should have_many(:posts) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
