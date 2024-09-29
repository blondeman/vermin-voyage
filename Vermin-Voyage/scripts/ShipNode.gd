extends Area2D
class_name ShipNode

var isMiddle: bool = false

func oppositePosition(symmetryLine: float) -> Vector2:
	return Vector2(position.x, position.y - 2 * (position.y - symmetryLine))
