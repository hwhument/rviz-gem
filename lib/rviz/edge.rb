module Rviz
  # represent a -> 
  class Edge
    attr_reader :attrs

    def initialize from_node, from_anchor, to_node, to_anchor = nil, attributes = {}
      @from, @from_anchor, @to, @to_anchor, @attrs = from_node, from_anchor, to_node, to_anchor, attributes
    end

    def node_anchor node, anchor
      if anchor and anchor.size > 0
        quote(node) + ":" + anchor
      else
        quote(node)
      end
    end

    include Helper

    # output to dot format
    def to_s
      from, to = node_anchor(@from, @from_anchor), node_anchor(@to, @to_anchor)
      if @attrs.keys.size > 0
        sprintf "%s -> %s [%s]", from, to, self.attrs_to_s
      else
        sprintf "%s -> %s", from, to
      end
    end
  end
end
