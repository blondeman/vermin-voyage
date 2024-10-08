extends Node2D
class_name ShipBuilder

@export var ship: Ship = null
@export var symmetryLine: float = 0
@export var ui: ShipBuilderUI = null

#var defaultNodePositions: Array = [Vector2(-400,0), Vector2(0,-150), Vector2(-100,-50), Vector2(100,-50), Vector2(400,0)]
#var defaultNodeLines: Array = [[0,1], [1,4], [2,3]]
var defaultNodePositions: Array = [Vector2(-400,0), Vector2(0,-150), Vector2(400,0)]
var defaultNodeLines: Array = [[0,1], [1,2]]

var shipBuilderDrag: ShipBuilderDrag = ShipBuilderDrag.new()
var shipBuilderControl: ShipBuilderControl = ShipBuilderControl.new()
var shipLoader: ShipLoader = ShipLoader.new()
var shipValidator: ShipValidator = ShipValidator.new()
var shipCalculator: ShipCalculator = ShipCalculator.new()

func _ready():
	shipBuilderDrag.init(ship, symmetryLine)
	shipBuilderControl.init(ship)
	shipCalculator.init(ship)
	
	ship.build(defaultNodePositions, defaultNodeLines)
	
	await get_tree().process_frame
	SetUI()

func _input(event):
	if event.is_action_released("ship_drag") && shipBuilderDrag.selectedNode != null:
		shipBuilderDrag.releaseNode()
		print("is valid: " +str(shipValidator.isValid(ship)))
	if event.is_action_released("ship_save"):
		shipLoader.saveShip(ship)
	if event.is_action_released("ship_load"):
		shipLoader.loadShip(ship)
		SetUI()

func _process(delta):
	if shipBuilderDrag.selectedNode:
		shipBuilderDrag.process_drag(get_global_mouse_position())
		SetUI()
		
func SetUI():
	if ui:
		ui.SetText(shipCalculator.GetCost(), shipCalculator.GetWeight(), shipCalculator.GetArea())
	

func dragNode(node: ShipNode):
	shipBuilderDrag.dragNode(node)

func deleteNode(node: ShipNode):
	shipBuilderControl.deleteNode(node)

func addNode(line: ShipLine):
	if shipBuilderDrag.selectedNode == null:
		dragNode(shipBuilderControl.addNode(line))
