module Rviz
  class Graph
    attr_accessor :subgraphs, :nodes, :edges
    
    def initialize attrs = {}
      @attrs = attrs
      @nodes = Hash.new
      @edges = Array.new
      @links = Array.new
      @subgraphs = Hash.new
    end

    def graph_start type = "digraph", name = "G"
      "#{type} #{name} {"
    end

    def graph_end; "}" end

    include Rviz::Helper
    def graph_attr
      @attrs["charset"] = "UTF-8" unless @attrs["charset"]
      sprintf("  graph [%s]", self.attrs_to_s)
    end

    def node_attr
      '  node [fontname="Arial Unicode MS", fontsize=9, width=2.0];'
    end

    def edge_attr
      '  edge [fontname="Arial Unicode MS", fontsize=7];'
    end

    # return a specific node from the node list
    def node name
      @nodes[name]
    end

    # add a node or create a node with name, shae and attributes
    def add name, shape='box', attrs = {}
      if name.is_a?(Node)
        node = name
        name = name.name
      else
        node = Node.new(name, shape, attrs)
      end
      
      @nodes[name] = node
      self
    end

    def add_subgraph
      # TODO
    end

    def add_record name, attr = {}
      @nodes[name] = Record.new(name, attr)
      self
    end

    def add_mrecord name, attr = {}
      @nodes[name] = Mrecord.new(name, attr)
      self
    end

    # create edge between two nodes
    def link from_name, from_anchor, to_name, to_anchor = "", attrs = {}
      @links << [from_name, from_anchor, to_name, to_anchor, attrs]
      self
    end

    def add_edge from_name, from_anchor, to_name, to_anchor, attrs = {}
      @edges << Edge.new(from_name, from_anchor, to_name, to_anchor, attrs)
      self
    end

    ## output dot language source to file or to STDOUT
    def output file=STDOUT
      fh = file
      fh = File.open(file, "w:utf-8") if file.is_a?(String)

      fh.puts self.graph_start
      fh.puts self.graph_attr
      fh.puts self.node_attr
      fh.puts self.edge_attr
      
      @nodes.each {|n,node| fh.puts "  " + node.to_s}

      @links.each do |ary|
        raise "#{ary[0]} not found as a node" unless @nodes[ary[0]] # from
        raise "#{ary[2]} not found as a node" unless @nodes[ary[2]] # to
        if %w[Mrecord record].include?(@nodes[ary[0]].shape)
          ary[1] = @nodes[ary[0]].get_anchor(ary[1])
          ary[3] = @nodes[ary[2]].get_anchor(ary[3])
        end
        @edges << Edge.new(*ary)
      end

      @edges.each {|e| fh.puts "  " + e.to_s}

      fh.puts self.graph_end
      fh.close
    end
  end

  class SubGraph < Graph
    attr_accessor :name
    def graph_start; "  subgraph #{self.name} {" end
    def graph_end; "  }" end
  end
end
