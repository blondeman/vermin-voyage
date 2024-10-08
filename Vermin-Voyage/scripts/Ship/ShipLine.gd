extends Line2D
class_name ShipLine

var isMain: bool = false
var nodeA: ShipNode = null
var nodeB: ShipNode = null
@onready var addHandle: Node2D
@onready var shipBuilder: ShipBuilder

func _ready():
	addHandle = find_child("AddHandle")
	shipBuilder = find_parent("ShipBuilder")

func setLine():
	points = [nodeA.position, nodeB.position]
	addHandle.position = getMidpoint()

func hasNode(node: ShipNode) -> bool:
	return node == nodeA or node == nodeB

func isValid(other: ShipLine, minAngle: float) -> bool:
	if other == self:
		return true
		
	if other.hasNode(nodeA) or other.hasNode(nodeB):
		var angle = getAngle(other)
		if angle >= minAngle:
			return true
		print("angle: " + str(angle))
		return false
	
	var intersect = getIntersection(other)
	if intersect == null:
		return true
	print("instersect: " + str(intersect))
	return false

func getAngle(other: ShipLine) -> float:
	var nodes = getRightHandNodes(other)
	var ab = nodes[0].position - nodes[1].position
	var bc = nodes[2].position - nodes[1].position
	var t = acos(ab.dot(bc) / (ab.length() * bc.length()))
	return rad_to_deg(t)

func getIntersection(other: ShipLine):
	var p0 = nodeA.position
	var p1 = nodeB.position
	var p2 = other.nodeA.position
	var p3 = other.nodeB.position
	var s1 = p1 - p0
	var s2 = p3 - p2
	var s = (-s1.y * (p0.x - p2.x) + s1.x * (p0.y - p2.y)) / (-s2.x * s1.y + s1.x * s2.y)
	var t = ( s2.x * (p0.y - p2.y) - s2.y * (p0.x - p2.x)) / (-s2.x * s1.y + s1.x * s2.y)

	if s >= 0 && s <= 1 && t >= 0 && t <= 1:
		var intersect = Vector2(p0.x + (t * s1.x), p0.y + (t * s1.y))
		return intersect
	return null

func getRightHandNodes(other: ShipLine) -> Array:
	var array: Array = Array()
	if nodeA == other.nodeA:
		array.append(nodeB)
		array.append(nodeA)
		array.append(other.nodeB)
	elif nodeB == other.nodeA:
		array.append(nodeA)
		array.append(nodeB)
		array.append(other.nodeB)
	elif nodeB == other.nodeB:
		array.append(nodeA)
		array.append(nodeB)
		array.append(other.nodeA)
	elif nodeA == other.nodeB:
		array.append(nodeB)
		array.append(nodeA)
		array.append(other.nodeA)
	return array

func getMidpoint() -> Vector2:
	return (nodeA.position + nodeB.position) / 2

func _on_add_handle_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("ship_drag"):
		shipBuilder.addNode(self)
