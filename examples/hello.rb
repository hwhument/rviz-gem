$:.unshift "lib", "../lib"
require 'rviz'

Rviz::Graph.new.add("Hello").add("World").link("Hello", "", "World").output
