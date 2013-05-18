# encoding: UTF-8
require 'spec_helper'

describe Post do
  context "validates" do
    subject { FactoryGirl.build(:post) }

    it { should be_valid }

    its(:published) { should == true }

    %w(title content slug).each do |attr|
      it { should validate_presence_of(attr.to_sym) }
      it { should validate_uniqueness_of(attr.to_sym) }
    end
  end

  context "tags" do
    subject { FactoryGirl.build(:post, tag_list: 'tag1,tag2') }
    it { should have_many(:tags) }
    it { should have_many(:taggings) }
    it { should respond_to(:tag_list) }

    its(:tag_list) { should == "tag1, tag2"}

    it "tags count ahange" do
      expect{FactoryGirl.create(:post, tag_list: 'tag1, tag2') }.to change{Tag.count}.by(2)
      expect{FactoryGirl.create(:post, tag_list: 'tag1, tag3')}.to change{Tag.count}.by(1)
    end

    it "tags count should not change when post not validate" do
      expect{FactoryGirl.build(:post, title: '', tag_list: 'tag4, tag5') }.to change{Tag.count}.by(0)
    end
  end

end
