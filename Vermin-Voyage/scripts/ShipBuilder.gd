extends Node2D
class_name ShipBuilder

@export var ship: Ship = null
@export var symmetryLine: float = 300
@export var minAngle: float = 10
var selectedNode: ShipNode = null

func _input(event):
	if event.is_action_released("ship_drag") && selectedNode != null:
		releaseNode()

func dragNode(node: ShipNode):
	selectedNode = node

func releaseNode():
	selectedNode = null
	print("is valid: " +str(ship.isValidShip(minAngle)))

func deleteNode(node: ShipNode):
	print("delteted")

func _process(delta):
	if selectedNode != null:
		selectedNode.setPosition(getValidNodePosition())
		for line in ship.findLines(selectedNode):
			line.setLine()

func getValidNodePosition() -> Vector2:
	var mousePos = get_global_mouse_position()
	if selectedNode.opposite == null:
		mousePos.y = symmetryLine
	return mousePos
