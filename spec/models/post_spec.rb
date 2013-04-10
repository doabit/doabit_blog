# encoding: UTF-8
require 'spec_helper'

describe Post do
  context "验证" do
    subject { FactoryGirl.build(:post) }

    it { should be_valid }

    its(:published) { should == false }

    %w(title content slug).each do |attr|
      it { should validate_presence_of(attr.to_sym) }
      it { should validate_uniqueness_of(attr.to_sym) }
    end

  end

end
