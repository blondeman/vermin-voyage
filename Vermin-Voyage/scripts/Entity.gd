extends CharacterBody2D
class_name Entity

@export var controller: Controller
@export var speed: float

func _physics_process(delta):
	velocity = controller.direction * speed
	move_and_slide()
