module Rviz
  # represent a -> 
  class Edge
    attr_reader :attrs

    def initialize from_node, from_anchor, to_node, to_anchor = nil, attributes = {}
      @from, @from_anchor, @to, @to_anchor, @attrs = from_node, from_anchor, to_node, to_anchor, attributes
    end

    include Helper

    # output to dot format
    def to_s
      attr_str = self.attrs_to_s
    end
  end
end
