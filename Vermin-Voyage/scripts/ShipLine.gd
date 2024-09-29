extends Line2D
class_name ShipLine

@export var nodeA: ShipNode = null
@export var nodeB: ShipNode = null

func setLine():
	points = [nodeA.position, nodeB.position]
