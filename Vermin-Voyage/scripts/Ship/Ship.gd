extends Node2D
class_name Ship

var shipNodeScene = preload("res://scenes/Ship/ShipNode.tscn")
var shipLineScene = preload("res://scenes/Ship/ShipLine.tscn")

var nodes: Array = []
var lines: Array = []

func build(nodePositions: Array, nodeLines: Array):
	for i in range(nodePositions.size()):
		var node = shipNodeScene.instantiate()
		add_child(node)
		nodes.append(node)
		
		node.isMain = true
		node.position = nodePositions[i]
		
		if i != 0 and i != nodePositions.size() - 1:
			var oppositeNode = shipNodeScene.instantiate()
			add_child(oppositeNode)
			
			oppositeNode.position = node.oppositePosition()
			node.opposite = oppositeNode
			oppositeNode.opposite = node

	for i in range(nodeLines.size()):
		var line = shipLineScene.instantiate()
		add_child(line)
		lines.append(line)
		
		line.isMain = true
		line.nodeA = nodes[nodeLines[i][0]]
		line.nodeB = nodes[nodeLines[i][1]]
		line.setLine()
		
		var oppositeLine = shipLineScene.instantiate()
		add_child(oppositeLine)
		lines.append(oppositeLine)
		
		oppositeLine.nodeA = nodes[nodeLines[i][0]].getOpposite()
		oppositeLine.nodeB = nodes[nodeLines[i][1]].getOpposite()
		oppositeLine.setLine()

func findLines(node: ShipNode) -> Array:
	var nodeLines = []
	for line in lines:
		if line.hasNode(node):
			nodeLines.append(line)
	return nodeLines

func findLinesOpposite(node: ShipNode) -> Array:
	var nodeLines = []
	for line in lines:
		if line.hasNode(node) or line.hasNode(node.getOpposite()):
			nodeLines.append(line)
	return nodeLines

func getOppositeLine(other: ShipLine) -> ShipLine:
	for line in lines:
		if line.hasNode(other.nodeA.getOpposite()) and line.hasNode(other.nodeB.getOpposite()):
			return line
	return null

func getLineNodeIndices(line: ShipLine) -> Array:
	return [nodes.find(line.nodeA), nodes.find(line.nodeB)]

func removeNode(node: ShipNode):
	nodes.erase(node)
	node.queue_free()

func removeLine(line: ShipLine):
	lines.erase(line)
	line.queue_free()

func clear():
	for line in lines:
		line.queue_free()
	lines.clear()
	for node in nodes:
		if node.opposite != null:
			node.opposite.queue_free()
		node.queue_free()
	nodes.clear()
