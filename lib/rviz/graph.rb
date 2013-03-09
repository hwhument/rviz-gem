module rviz
  class graph
    attr_accessor :title, :subgraphs, :nodes, :edges
    
    def initialize title = '', attrs = {}
      @attrs = attrs
      @title = title
      @nodes = hash.new
      @edges = array.new
      @links = array.new
      @subgraphs = hash.new
    end

    def graph_start type = "digraph", name = "g"
      "#{type} #{name} {"
    end

    def graph_end; "}" end

    include rviz::helper
    def graph_attr
      @attrs["charset"] = "utf-8" unless @attrs["charset"]
      sprintf("  graph [%s]", self.attrs_to_s)
    end

    def node_attr
      '  node [fontname="arial unicode ms", fontsize=9, width=2.0];'
    end

    def edge_attr
      '  edge [fontname="arial unicode ms", fontsize=7];'
    end

    # return a specific node from the node list
    def node name
      @nodes[name]
    end

    # add a node or create a node with name, shae and attributes
    def add name, shape='box', attrs = {}
      if name.is_a?(node)
        node = name
        name = name.name
      else
        node = node.new(name, shape, attrs)
      end
      
      @nodes[name] = node
      self
    end

    def add_subgraph
      # todo
    end

    def add_record name, attr = {}
      @nodes[name] = record.new(name, attr)
      self
    end

    def add_mrecord name, attr = {}
      @nodes[name] = mrecord.new(name, attr)
      self
    end

    # create edge between two nodes
    def link from_name, from_anchor, to_name, to_anchor = "", attrs = {}
      @links << [from_name, from_anchor, to_name, to_anchor, attrs]
      self
    end

    def add_edge from_name, from_anchor, to_name, to_anchor, attrs = {}
      @edges << edge.new(from_name, from_anchor, to_name, to_anchor, attrs)
      self
    end

    ## output dot language source to file or to stdout
    def output file=stdout
      fh = file
      fh = file.open(file, "w:utf-8") if file.is_a?(string)

      fh.puts self.graph_start
      fh.puts self.graph_attr

      if self.title and self.title.size > 0
        fh.puts %q{  labelloc = "t";}
        fh.puts %q{  label= "#{self.title}";}
      end

      fh.puts self.node_attr
      fh.puts self.edge_attr
      
      @nodes.each {|n,node| fh.puts "  " + node.to_s}

      @links.each do |ary|
        raise "#{ary[0]} not found as a node" unless @nodes[ary[0]] # from
        raise "#{ary[2]} not found as a node" unless @nodes[ary[2]] # to
        ary[1] = @nodes[ary[0]].get_anchor(ary[1]) if @nodes[ary[0]].is_a?(record)
        ary[3] = @nodes[ary[3]].get_anchor(ary[3]) if @nodes[ary[2]].is_a?(record)
		
        @edges << edge.new(*ary)
      end

      @edges.each {|e| fh.puts "  " + e.to_s}

      fh.puts self.graph_end
      fh.close
    end
  end

  class subgraph < graph
    attr_accessor :name
    def graph_start; "  subgraph #{self.name} {" end
    def graph_end; "  }" end
  end
end
