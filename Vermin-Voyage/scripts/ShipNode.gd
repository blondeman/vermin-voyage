extends Area2D
class_name ShipNode

#null opposite means it's a center node
var opposite: ShipNode = null

func oppositePosition(symmetryLine: float) -> Vector2:
	return Vector2(position.x, position.y - 2 * (position.y - symmetryLine))

func getOpposite() -> ShipNode:
	if opposite:
		return opposite
	else:
		return self
