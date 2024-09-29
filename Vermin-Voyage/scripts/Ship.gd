extends Node2D
class_name Ship

var shipNodeScene = preload("res://scenes/ShipNode.tscn")
var shipLineScene = preload("res://scenes/ShipLine.tscn")

var nodePositions: Array = [Vector2(50,100), Vector2(450,30), Vector2(850,100)]
var nodeLines: Array = [Vector2(0,1), Vector2(1,2)]

var symmetryLine: float = 0 
var nodes: Array = []
var lines: Array = []

func _ready():
	build()
	
func build():
	for i in range(nodePositions.size()):
		var node = shipNodeScene.instantiate()
		add_child(node)
		
		if i == 0 or i == nodePositions.size() - 1:
			node.isMiddle = true
		node.position = nodePositions[i]
		nodes.append(node)
	
	for i in range(nodeLines.size()):
		var line = shipLineScene.instantiate()
		add_child(line)
		
		line.nodeA = nodes[nodeLines[i].x]
		line.nodeB = nodes[nodeLines[i].y]
		line.setLine()
		lines.append(line)
