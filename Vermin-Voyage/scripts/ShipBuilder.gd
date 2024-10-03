extends Node2D
class_name ShipBuilder

@export var ship: Ship = null
@export var symmetryLine: float = 300

var defaultNodePositions: Array = [Vector2(50,300), Vector2(450,30), Vector2(450,200), Vector2(550,200), Vector2(850,300)]
var defaultNodeLines: Array = [[0,1], [1,4], [2,3]]

var shipBuilderDrag: ShipBuilderDrag = ShipBuilderDrag.new()
var shipBuilderControl: ShipBuilderControl = ShipBuilderControl.new()
var shipLoader: ShipLoader = ShipLoader.new()
var shipValidator: ShipValidator = ShipValidator.new()

func _ready():
	shipBuilderDrag.init(ship, symmetryLine)
	shipBuilderControl.init(ship)
	
	ship.build(defaultNodePositions, defaultNodeLines)

func _input(event):
	if event.is_action_released("ship_drag") && shipBuilderDrag.selectedNode != null:
		shipBuilderDrag.releaseNode()
		print("is valid: " +str(shipValidator.isValid(ship)))
	if event.is_action_released("ship_save"):
		shipLoader.saveShip(ship)
	if event.is_action_released("ship_load"):
		shipLoader.loadShip(ship)

func _process(delta):
	shipBuilderDrag.process_drag(get_global_mouse_position())

func dragNode(node: ShipNode):
	shipBuilderDrag.dragNode(node)

func deleteNode(node: ShipNode):
	shipBuilderControl.deleteNode(node)

func addNode(line: ShipLine):
	if shipBuilderDrag.selectedNode == null:
		dragNode(shipBuilderControl.addNode(line))
