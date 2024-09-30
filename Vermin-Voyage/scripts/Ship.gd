extends Node2D
class_name Ship

var shipNodeScene = preload("res://scenes/ShipNode.tscn")
var shipLineScene = preload("res://scenes/ShipLine.tscn")

var nodePositions: Array = [Vector2(50,100), Vector2(450,30), Vector2(850,100)]
var nodeLines: Array = [Vector2(0,1), Vector2(1,2)]

var symmetryLine: float = 100 
var nodes: Array = []
var lines: Array = []

func _ready():
	build(nodePositions, nodeLines)
	
func build(nodePositions: Array, nodeLines: Array):
	for i in range(nodePositions.size()):
		var node = shipNodeScene.instantiate()
		node.position = nodePositions[i]
		
		add_child(node)
		nodes.append(node)
		
		if i != 0 and i != nodePositions.size() - 1:
			var oppositeNode = shipNodeScene.instantiate()
			oppositeNode.position = node.oppositePosition(symmetryLine)
			node.opposite = oppositeNode
			oppositeNode.opposite = node
			
			add_child(oppositeNode)


	for i in range(nodeLines.size()):
		var line = shipLineScene.instantiate()
		line.nodeA = nodes[nodeLines[i].x]
		line.nodeB = nodes[nodeLines[i].y]
		line.setLine()
		
		add_child(line)
		lines.append(line)
		
		var oppositeLine = shipLineScene.instantiate()
		oppositeLine.nodeA = nodes[nodeLines[i].x].getOpposite()
		oppositeLine.nodeB = nodes[nodeLines[i].y].getOpposite()
		oppositeLine.setLine()
		
		add_child(oppositeLine)
		lines.append(oppositeLine)
