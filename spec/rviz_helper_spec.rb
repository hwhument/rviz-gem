require "spec_helper"

describe Rviz do
  describe "#attrs_to_s" do
    it "return attribute set in format" do
      # mock up
      m = Rviz::Edge.new "from", "", "to", ""
      m.set("label", "full stack")
      m.attrs_to_s.should eq(%q{label="full stack"})
    end
  end
end

