class_name ShipValidator

var minAngle: float = 10
var minDistance: float = 20

func isValid(ship: Ship) -> bool:
	for lineA in ship.lines:
		for lineB in ship.lines:
			if not lineA.isValid(lineB, minAngle):
				return false
	
	for node in ship.nodes:
		if len(ship.findLines(node)) != 2:
			print("invalid nodes: " + str(node))
			return false
	
	return true
