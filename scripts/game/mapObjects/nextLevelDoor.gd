extends StaticBody2D
class_name NextLevelDoor

@export var game: Game
@export var camera: GameCamera
@export var player: Player

func _ready():
	$sprite.frame = 0

func nextLevel():
	$sprite.frame = 0
	player.global_position.x += 320
	camera.global_position.x += 320
	global_position.x += 320
	game.level += 1

func _on_area_col_area_entered(area):
	if area.is_in_group("player"):
		$sprite.play()

func _on_sprite_animation_finished():
	nextLevel()
	await get_tree().create_timer(2).timeout
	game.changeLevel()
