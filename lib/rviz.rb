module Rviz
  module Helper
    # convert attr hash to a string in dot format
    def attrs_to_s
      attr_strs = Array.new

      @attrs.each do |k,v| 
        v = v.to_s
        v = "\"#{v}\"" if v.match(/\W/)
        attr_strs << sprintf('%s=%s', k.to_s, v)
      end
      attr_strs.join(", ")
    end

    def set key, value
      @attrs[key] = value
    end

    def quote str
      if str =~ /^\w+$/
        str
      else
        %Q|"#{str}"|
      end
    end
  end
end

require "rviz/edge.rb"
require "rviz/graph.rb"
require "rviz/node.rb"
