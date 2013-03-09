module Rviz
  class Record < Node
    def initialize name, attrs = {}
      super name, "record", attrs
      @label_rows = Array.new
      @anchors = Hash.new
    end

    # from row_name returns the id corresponds to the anchor
    def get_anchor_id row_name
      @anchors[row_name]
    end

    # get the anchor name used for edge link
    def get_anchor row_name
      "f" + self.get_anchor_id(row_name).to_s if get_anchor_id(row_name)
    end

    def add_row row_name, create_anchor = false, port_pos = 'n'
      if create_anchor 
        anchor_id = @anchors.keys.size + 1
        @anchors[row_name] = anchor_id
        row_name.gsub!(/([\/\|\\\<\>])/, '-') # escape special characters
        row_name = "<f#{anchor_id.to_s}>" + row_name
      end
      if port_pos
        raise "unknown port_pos, should in l, r or n" unless %w[l r n].include? port_pos
      end
      @label_rows << [row_name, port_pos]
      self
    end

    def label_with_rows
      labels = Array.new
      i =0
      @label_rows.each do |a|
        str, lr = a[0], a[1]
        str += " \\" + lr if %w[l r].include? lr
        labels << str
      end
      labels.join('|')
    end

    def to_s
      @attrs['label'] = self.label_with_rows
      super
    end
  end

  # a convenient way to inherit Record functions
  class Mrecord < Record
    def initialize name, attrs = {}
      super name, attrs
      @attrs["shape"] = "Mrecord"
    end
  end
end
