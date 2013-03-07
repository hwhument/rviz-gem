Rviz: An Other Ruby Interface for Graphviz
==============================================

Provide a simple OOP interface and designed easy to extend.

    g = Rviz::Graph.new
    g.set('bgcolor', 'kahki')
    g.set('dpi', '300')
    g.set('rankdir', 'LR')
    node_a = g.add_node('Node A', 'diamond')
    node_b = g.add_node('Node B', 'box')
    edge_a = g.add_edge('Node A', '', 'Node B', '', {arrowhead: 'onormal'})

    node_a.set('fillcolor', 'yellow')
    g.node('Node A').set('fillcolor', 'yellow') # same as above

    other_node = Rviz::Node.new('The Node', 'diamond')
    g.add(other_node) # same as g.add_node(...)

    g.output('some.dot') # generate a dot file
    g.output # send output to STDOUT

An easy way to create `record` and `Mrecord` type of nodes:

    g.add_record('Record A')
    g.node('Record A').add_row('A Row 1', true) # add an anchor
    g.node('Record A').add_row('A Row 2', true) # add an anchor
    g.node('Record A').add_row('A Row 3', true) # add an anchor

    g.add_record('Record B')
    g.node('Record B').add_row('B Row 1', true) # add an anchor
    g.add_edge('Record A', 'A Row 2', 'Record B', 'B Row 1', {label: 'link A:2 to B:1'})

You can extend `Rviz` very easy:

    # in file red_note.rb
    module Rviz
      class RedNote < Note
        def initialize name
          @attrs[:name] = name
          @attrs[:shape] = 'note'
          @attrs[:style] = 'filled'
          @attrs[:fillcolor] = 'red'
        end
      end
    end

    # in your program:
    g = Rviz::Graph.new
    g.add(Rviz::RedNote.new('Red'))
    g.output('notes.dot')

And you can also mixin the `Graph` class:

    # in file red_note.rb
    module Rviz
      class RedNote < Note
        def initialize name
          @attrs[:name] = name
          @attrs[:shape] = 'note'
          @attrs[:style] = 'filled'
          @attrs[:fillcolor] = 'red'
        end
      end
    end

    module Rviz
      class Graph
        def add_red_note name
          self.add(RedNote(name))
        end
      end
    end

    # now in your main program:
    g = Rviz::Graph.new
    g.add_red_note('Bloody Notes')
    g.output('notes.dot')

