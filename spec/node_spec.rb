require "spec_helper"

describe Rviz::Node do
  describe "#to_s" do
    it "should return a node in plain format" do
      Rviz::Node.new("glue").to_s.should eq %Q{glue [shape=box]}
    end

    it "should return a note with specific shape and attribute" do
      Rviz::Node.new("glue", "note", {color: "red"}).to_s.should eq %Q{glue [shape=note, color=red]}
    end
  end
end
