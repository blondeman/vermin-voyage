class_name ShipValidator

var minAngle: float = 10
var minDistance: float = 20

func isValid(ship: Ship) -> bool:
	for lineA in ship.lines:
		for lineB in ship.lines:
			if not lineA.isValid(lineB, minAngle):
				return false
	#check for node distance
	#check for node and line connectivity
	return true
