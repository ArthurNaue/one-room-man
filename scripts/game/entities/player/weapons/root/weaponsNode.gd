extends Node2D
class_name PlayerWeaponsNode

var attacking: bool

func _ready():
	attacking = false

func _process(delta: float):
	if attacking == false:
		Direction()

#funcao de mudar a direcao da arma
func Direction():
	var mouseDirection: Vector2 = (get_global_mouse_position() - global_position).normalized()
	rotation = mouseDirection.angle()
	if scale.y == 1 and mouseDirection.x < 0:
		scale.y = -1
	elif scale.y == -1 and mouseDirection.x > 0:
		scale.y = 1
