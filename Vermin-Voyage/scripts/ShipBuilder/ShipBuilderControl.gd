class_name ShipBuilderControl

var ship: Ship

func init(ship: Ship):
	self.ship = ship

func deleteNode(node: ShipNode):
	if node.opposite != null and ship.nodes.size() > 3:
		var lines = ship.findLines(node)
		if lines.size() == 2:
			var nodes = lines[0].getRightHandNodes(lines[1])
			if lines[0].nodeA == nodes[0]:
				lines[0].nodeB = nodes[2]
			else:
				lines[0].nodeA = nodes[2]
			lines[0].setLine()
			ship.removeNode(nodes[1])
			ship.removeLine(lines[1])
		
		lines = ship.findLines(node.opposite)
		if lines.size() == 2:
			var nodes = lines[0].getRightHandNodes(lines[1])
			if lines[0].nodeA == nodes[0]:
				lines[0].nodeB = nodes[2]
			else:
				lines[0].nodeA = nodes[2]
			lines[0].setLine()
			ship.removeNode(nodes[1])
			ship.removeLine(lines[1])

func addNode(line: ShipLine) -> ShipNode:
	var oppositeLine = ship.getOppositeLine(line)
	var tempNode = line.nodeB
	var oppositeTempNode = oppositeLine.nodeB
	
	#Set Nodes
	var node = ship.shipNodeScene.instantiate()
	var oppositeNode = ship.shipNodeScene.instantiate()
	ship.add_child(node)
	ship.add_child(oppositeNode)
	ship.nodes.insert(ship.nodes.size()-2, node)
	
	node.isMain = line.isMain
	node.position = line.getMidpoint()
	node.opposite = oppositeNode
	oppositeNode.isMain = !line.isMain
	oppositeNode.position = node.oppositePosition()
	oppositeNode.opposite = node
	
	#Change existing line
	line.nodeB = node
	line.setLine()
	
	#Create new line
	var newLine = ship.shipLineScene.instantiate()
	ship.add_child(newLine)
	ship.lines.append(newLine)
	newLine.isMain = line.isMain
	newLine.nodeA = node
	newLine.nodeB = tempNode
	newLine.setLine()
	
	#Change existing opposite line
	oppositeLine.nodeB = node.getOpposite()
	oppositeLine.setLine()
	
	#Create new opposite line
	var oppositeNewLine = ship.shipLineScene.instantiate()
	ship.add_child(oppositeNewLine)
	ship.lines.append(oppositeNewLine)
	oppositeNewLine.isMain = !line.isMain
	oppositeNewLine.nodeA = node.getOpposite()
	oppositeNewLine.nodeB = oppositeTempNode
	oppositeNewLine.setLine()
	
	return node
