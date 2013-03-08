require "spec_helper"

describe Rviz do
  describe "#attrs_to_s" do
    it "return attribute set in format" do
      # mock up
      m = Rviz::Edge.new "from", "", "to", ""
      m.set("label", "full stack")
      m.attrs_to_s.should eq(%q{label="full stack"})
    end

    it "return initial attributes in format" do
      m = Rviz::Edge.new "from", "", "to", "", {arrowhead: "onormal"}
      m.set("label", "full stack")
      m.attrs_to_s.should eq(%q{arrowhead=onormal, label="full stack"})
    end
  end
end

