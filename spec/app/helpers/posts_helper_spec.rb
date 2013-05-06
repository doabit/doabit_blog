require 'spec_helper'

describe "PostsHelper" do
  subject do
    Class.new { include PostHelpers }
  end

  it "get day < 10" do
    date  = Time.local(2013, 9, 1, 10, 5, 0)
    subject.new.get_day(date).should == '01'
  end

  it "get day > 10" do
    date = Time.local(2013, 9, 22, 10, 5, 0)
    subject.new.get_day(date).should == '22'
  end

  it "get month < 10" do
    date = Time.local(2013, 9, 22, 10, 5, 0)
    subject.new.get_year_manth(date).should == '09 / 2013'
  end

  it "get month > 10" do
    date = Time.local(2013, 11, 22, 10, 5, 0)
    subject.new.get_year_manth(date).should == '11 / 2013'
  end

end
