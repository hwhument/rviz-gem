# encoding: utf-8
$:.unshift "lib", "../lib"
require 'rviz'

g = Rviz::Graph.new
g.add(Rviz::Record.new('To', {color: 'blue'}))
g.add(Rviz::Mrecord.new('Fu', {color: 'green'}))

g.node('To').add_row("Hello").add_row("World", true)
g.node('Fu').add_row("你好", true).add_row("世界")

g.link('To', "World", 'Fu', "你好")
g.output
