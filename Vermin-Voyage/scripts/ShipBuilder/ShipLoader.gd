class_name ShipLoader

var filePath: String = "user://ship_1.dat"

func saveShip(ship: Ship):
	var nodes = []
	var lines = []
	
	for node in ship.nodes:
		nodes.append([node.position.x, node.position.y])
	for line in ship.lines:
		if line.isMain:
			lines.append(ship.getLineNodeIndices(line))
	
	var json = {
		"nodes":nodes,
		"lines":lines
	}
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	file.store_string(JSON.stringify(json))

	
func loadShip(ship: Ship):
	ship.clear()
	var file = FileAccess.open(filePath, FileAccess.READ)
	var json = JSON.parse_string(file.get_as_text())
	
	var nodes = []
	for node in json.nodes:
		nodes.append(Vector2(node[0], node[1]))
	var lines = json.lines
	ship.build(nodes, lines)
