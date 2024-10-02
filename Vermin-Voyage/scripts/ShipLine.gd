extends Line2D
class_name ShipLine

var nodeA: ShipNode = null
var nodeB: ShipNode = null

func setLine():
	points = [nodeA.position, nodeB.position]

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
	var a: Vector2 = Vector2.ZERO
	var b: Vector2 = Vector2.ZERO
	var c: Vector2 = Vector2.ZERO
	
	if nodeA == other.nodeA:
		a = nodeB.position
		b = nodeA.position
		c = other.nodeB.position
	elif nodeB == other.nodeA:
		a = nodeA.position
		b = nodeB.position
		c = other.nodeB.position
	elif nodeB == other.nodeB:
		a = nodeA.position
		b = nodeB.position
		c = other.nodeA.position
	elif nodeA == other.nodeB:
		a = nodeB.position
		b = nodeA.position
		c = other.nodeA.position
		
	var ab = a - b
	var bc = c - b
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
