class_name ShipCalculator

var ship: Ship

func init(ship: Ship):
	self.ship = ship

func GetArea() -> float:
	var nodes = GetOrderedNodes()
	var area: float = 0 
	for i in range(len(nodes) - 1):
		area += GetAreaUnder(nodes[i], nodes[i + 1])
	return -area * 2

func GetAreaUnder(p1: Vector2, p2: Vector2) -> float:
	var width = p2.x - p1.x
	var height = (p2.y + p1.y) / 2
	return width * height

func GetWeight() -> float:
	return GetArea() * 1.2

func GetCost() -> float:
	return round(GetArea() / 100)

func GetOrderedNodes() -> Array:
	var previousNode = ship.nodes[0]
	var nodes: Array = [previousNode.position]
	var previousLine = null

	while previousNode != ship.nodes[-1]:
		var nodeLines = ship.findLines(previousNode)
		for line in nodeLines:
			if line.isMain and line != previousLine:
				previousLine = line
				break
		if previousLine.nodeA == previousNode:
			previousNode = previousLine.nodeB
		else:
			previousNode = previousLine.nodeA
		nodes.append(previousNode.position)
	return nodes
