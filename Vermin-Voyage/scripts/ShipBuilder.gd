extends Node2D
class_name ShipBuilder

@export var ship: Ship = null
@export var symmetryLine: float = 300
@export var minAngle: float = 10

var shipBuilderDrag: ShipBuilderDrag = ShipBuilderDrag.new()
var shipBuilderControl: ShipBuilderControl = ShipBuilderControl.new()

func _ready():
	shipBuilderDrag.init(ship, symmetryLine, minAngle)
	shipBuilderControl.init(ship)

func _input(event):
	if event.is_action_released("ship_drag") && shipBuilderDrag.selectedNode != null:
		shipBuilderDrag.releaseNode()

func _process(delta):
	shipBuilderDrag.process_drag(get_global_mouse_position())

func dragNode(node: ShipNode):
	shipBuilderDrag.dragNode(node)

func deleteNode(node: ShipNode):
	shipBuilderControl.deleteNode(node)

func addNode(line: ShipLine):
	dragNode(shipBuilderControl.addNode(line))
