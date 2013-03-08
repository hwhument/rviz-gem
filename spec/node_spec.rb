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

describe Rviz::Record do
  describe "#to_s" do
    it "should return a record node in plain format" do
      ar = Rviz::Record.new('a_record')
      ar.add_row("A Row")
      ar.add_row("B Row")
      ar.to_s.should eq %Q{a_record [shape=record, label="A Row|B Row"]}
    end

    it "should return a record node with an anchor" do
      ar = Rviz::Record.new('a_record')
      ar.add_row("A Row", true)
      ar.add_row("B Row")
      ar.to_s.should eq %Q{a_record [shape=record, label="<f1>A Row|B Row"]}
    end

    it "should return a record node with more anchors" do
      ar = Rviz::Record.new('a_record')
      ar.add_row("A Row", true)
      ar.add_row("B Row", true)
      ar.add_row("C Row", true)
      ar.to_s.should eq %Q{a_record [shape=record, label="<f1>A Row|<f2>B Row|<f3>C Row"]}
    end
  end

  describe "#get_anchor" do
    it "should labeled some row with proper id" do
      ar = Rviz::Record.new('a_record')
      ar.add_row("A Row", true)
      ar.add_row("B Row", true)
      ar.add_row("C Row", true)
      ar.get_anchor_id("C Row").should eq(3)
      ar.get_anchor("B Row").should eq("f2")
    end
  end
end

describe Rviz::Mrecord do
  describe "#to_s" do
    it "should have a shape of Mrecord" do
      Rviz::Mrecord.new('m_record').shape.should eq "Mrecord"
    end
  end
end



