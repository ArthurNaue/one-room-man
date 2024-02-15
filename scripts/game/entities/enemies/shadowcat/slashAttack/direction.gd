extends Node2D
class_name ShadowCatDirection

@onready var game = get_tree().get_first_node_in_group("game")

#funcao de mudar a direcao da arma
func Direction():
	var playerPosition: Vector2 = (game.get_node("player").global_position - global_position).normalized()
	rotation = playerPosition.angle()
	if scale.y == 1 and playerPosition.x < 0:
		scale.y = -1
	elif scale.y == -1 and playerPosition.x > 0:
		scale.y = 1
