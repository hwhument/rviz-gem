module Rviz
  class Node
    def initialize name, shape = "box", attrs = {}
      @name = name
      @attrs = {"shape" => shape}.merge attrs
      $stderr.puts "You can use Record or Mrecord class for specific add-on functions" if shape == 'record' or shape == 'Mrecord'
    end

    include Rviz::Helper

    # print out as dot source
    def to_s
      sprintf '%s [%s]', self.quote(@name), self.attrs_to_s
    end
  end
end
