module Rviz
  class Node
    attr_accessor :name
    def initialize name, shape = "box", attrs = {}
      @name = name
      @attrs = {"shape" => shape}.merge attrs
    end

    def shape
      @attrs["shape"]
    end

    include Rviz::Helper

    # print out as dot source
    def to_s
      sprintf '%s [%s]', self.quote(@name), self.attrs_to_s
    end
  end
end
