extends Controller
class_name PlayerController

func GetDirection() -> Vector2:
	var inputDirection: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	return inputDirection
