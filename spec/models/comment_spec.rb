require 'spec_helper'

describe Comment do
  describe "validate" do
    subject { FactoryGirl.build :comment }
    it { should be_valid }
    it { should belong_to(:account) }
    it { should belong_to(:post) }
    it { should validate_presence_of(:content) }
  end
end
