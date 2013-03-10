module Rviz
  module Helper
    # convert attr hash to a string in dot format
    def attrs_to_s
      attr_strs = Array.new

      @attrs.each do |k,v|
        k = self.quote(k)
        v = self.quote(v)
        attr_strs << sprintf('%s=%s', k, v)
      end
      attr_strs.join(", ")
    end

    def set key, value
      @attrs[key] = value
    end

    def quote str
      if str.to_s.match(/\W/)
        %Q{"#{str.to_s}"}
      else
        str.to_s
      end
    end
  end
end

require "rviz/edge.rb"
require "rviz/graph.rb"
require "rviz/node.rb"
require "rviz/record.rb"
