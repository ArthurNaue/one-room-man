extends CharacterBody2D
class_name Mage

@export var speed: int
@onready var player = get_tree().get_first_node_in_group("player")
var direction: Vector2

func _physics_process(_delta):
	var distance = player.global_position - global_position
	if distance.length() < 100:
		velocity = direction * speed
	else:
		velocity = distance * 0.2

	move_and_slide()

func _on_move_timer_timeout():
	#randomiza a direcao que o inimigo tem que ir
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func _on_shoot_timer_timeout():
	#atira a bala
	Enemies.shoot(global_position, player.global_position, "bullet", 200)
