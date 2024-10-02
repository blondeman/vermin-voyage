extends Area2D
class_name ShipNode

#null opposite means it's a center node
var opposite: ShipNode = null
@onready var shipBuilder: ShipBuilder

func _ready():
	shipBuilder = find_parent("ShipBuilder")

func setPosition(pos: Vector2):
	position = pos
	if opposite:
		opposite.position = oppositePosition()

func oppositePosition() -> Vector2:
	return Vector2(position.x, position.y - 2 * (position.y - shipBuilder.symmetryLine))

func getOpposite() -> ShipNode:
	if opposite:
		return opposite
	else:
		return self

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ship_drag"):
		shipBuilder.dragNode(self)
	if event.is_action_released("ship_delete"):
		shipBuilder.deleteNode(self)
