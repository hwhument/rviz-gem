$:.unshift "lib", "../lib"
require 'rviz'

Rviz::Graph.new("Hello Word Example").add("Hello").add("World").link("Hello", "", "World").output
