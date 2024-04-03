extends Sprite2D
class_name MageStaff

@onready var player = get_tree().get_first_node_in_group("player")

func _process(_delta):
	var playerDirection: Vector2 = (player.global_position - global_position).normalized()
	rotation = playerDirection.angle()
	if scale.y == 1 and playerDirection.x < 0:
		scale.y = -1
	elif scale.y == -1 and playerDirection.x > 0:
		scale.y = 1
