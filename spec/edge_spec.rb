require "spec_helper"

describe Rviz::Edge do
  describe "#to_s" do
    it "should format a plain link" do
      Rviz::Edge.new("A", "", "B").to_s.should eq "A -> B"
    end

    it "should format link with from anchor" do
      Rviz::Edge.new("A", "a", "B").to_s.should eq "A:a -> B"
    end

    it "should format link with to anchor" do
      Rviz::Edge.new("A", "", "B", "b").to_s.should eq "A -> B:b"
    end

    it "should format link with both anchor" do
      Rviz::Edge.new("A", "a", "B", "b").to_s.should eq "A:a -> B:b"
    end

    it "should format link with special from node" do
      Rviz::Edge.new("A C", "a", "B", "b").to_s.should eq %q|"A C":a -> B:b|
    end

    it "should format link with special nodes" do
      Rviz::Edge.new("A C", "a", "B D", "b").to_s.should eq %q|"A C":a -> "B D":b|
    end

    it "should format link with label attributes" do
      Rviz::Edge.new("A B C", "a", "B", "", {label: "Send to me"}).to_s.should eq %q{"A B C":a -> B [label="Send to me"]}
    end

    it "should format link with more attributes" do
      Rviz::Edge.new("A B C", "a", "B", "", {label: "Send to me", color: "black"}).to_s.should eq %q{"A B C":a -> B [label="Send to me", color=black]}
    end
  end
end

