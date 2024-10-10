extends CharacterBody2D
class_name Entity

@export var controller: Controller
@export var speed: float

func _physics_process(delta):
	# simplified for example
	velocity = controller.direction * speed
	print(controller.direction)
	move_and_slide()
