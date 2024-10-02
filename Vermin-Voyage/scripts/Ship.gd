extends Node2D
class_name Ship

var shipNodeScene = preload("res://scenes/ShipNode.tscn")
var shipLineScene = preload("res://scenes/ShipLine.tscn")

var nodePositions: Array = [Vector2(50,300), Vector2(450,30), Vector2(650,30), Vector2(850,300)]
var nodeLines: Array = [[0,1], [1,2], [2,3]]

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
			oppositeNode.position = node.oppositePosition()
			node.opposite = oppositeNode
			oppositeNode.opposite = node
			
			add_child(oppositeNode)


	for i in range(nodeLines.size()):
		var line = shipLineScene.instantiate()
		line.nodeA = nodes[nodeLines[i][0]]
		line.nodeB = nodes[nodeLines[i][1]]
		line.setLine()
		
		add_child(line)
		lines.append(line)
		
		var oppositeLine = shipLineScene.instantiate()
		oppositeLine.nodeA = nodes[nodeLines[i][0]].getOpposite()
		oppositeLine.nodeB = nodes[nodeLines[i][1]].getOpposite()
		oppositeLine.setLine()
		
		add_child(oppositeLine)
		lines.append(oppositeLine)

func findLines(node: ShipNode) -> Array:
	var nodeLines = []
	for line in lines:
		if line.hasNode(node) or line.hasNode(node.getOpposite()):
			nodeLines.append(line)
	return nodeLines

func isValidShip(minAngle: float) -> bool:
	for lineA in lines:
		for lineB in lines:
			if not lineA.isValid(lineB, minAngle):
				return false
	return true
