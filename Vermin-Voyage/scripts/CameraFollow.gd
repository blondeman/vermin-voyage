extends Camera2D

@export var target: Node2D
@export var smooth: float = 20

func _process(delta):
	if target:
		position = lerp(position, target.position, delta * smooth)
