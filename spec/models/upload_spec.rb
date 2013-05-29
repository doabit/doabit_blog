require 'spec_helper'

describe Upload do
  describe "validate" do
    subject { Upload.new }
    it {should validate_presence_of :file}
  end
end
