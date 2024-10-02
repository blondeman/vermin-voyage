class_name ShipBuilderDrag

var ship: Ship
var symmetryLine: float
var minAngle: float
var selectedNode: ShipNode = null

func init(ship: Ship, symmetryLine: float, minAngle: float):
	self.ship = ship
	self.symmetryLine = symmetryLine
	self.minAngle = minAngle

func dragNode(node: ShipNode):
	selectedNode = node
	
func releaseNode():
	selectedNode = null
	print("is valid: " +str(ship.isValidShip(minAngle)))

func process_drag(mousePosition: Vector2):
	if selectedNode != null:
		selectedNode.setPosition(getValidNodePosition(mousePosition))
		for line in ship.findLinesOpposite(selectedNode):
			line.setLine()

func getValidNodePosition(mousePosition: Vector2) -> Vector2:
	if selectedNode.opposite == null:
		mousePosition.y = symmetryLine
	return mousePosition
