class_name ShipBuilderDrag

var ship: Ship
var symmetryLine: float
var selectedNode: ShipNode = null

func init(ship: Ship, symmetryLine: float):
	self.ship = ship
	self.symmetryLine = symmetryLine

func dragNode(node: ShipNode):
	selectedNode = node
	
func releaseNode():
	selectedNode = null

func process_drag(mousePosition: Vector2):
	if selectedNode != null:
		selectedNode.setPosition(getValidNodePosition(mousePosition))
		for line in ship.findLinesOpposite(selectedNode):
			line.setLine()

func getValidNodePosition(mousePosition: Vector2) -> Vector2:
	if selectedNode.opposite == null:
		mousePosition.y = symmetryLine
	elif selectedNode.isMain and mousePosition.y > symmetryLine:
		mousePosition.y = symmetryLine
	elif not selectedNode.isMain and mousePosition.y < symmetryLine:
		mousePosition.y = symmetryLine
	return mousePosition
