require 'spec_helper'

describe Tagging do
  describe "validate" do
    subject { Tagging.new }
    it {should belong_to :tag}
    it {should belong_to :post}
  end
end
