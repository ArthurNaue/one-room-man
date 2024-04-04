extends CharacterBody2D
class_name bombKingBomb

#variaveis
@export var speed: int
@export var explosionScene: PackedScene
@onready var player = get_tree().get_first_node_in_group("player")
@onready var game = get_tree().get_first_node_in_group("game")
@onready var explodePlace = player.global_position
@onready var direction = (explodePlace - position).normalized()
@onready var explodeTimer = $explodeTimer

func _ready():
	#randomiza o tempo de explosao
	explodeTimer.wait_time = randf_range(0.5, 1)
	#comeca o timer de explosao
	explodeTimer.start()
	#muda o angulo para a direcao do playea
	look_at(explodePlace)

func _physics_process(_delta):
	#aplica movimento na bomba
	velocity = direction * speed
	move_and_slide()

#funcao que verifica se o objeto colidiu
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um player
	if area.is_in_group("player"):
		explode()

func _on_explode_timer_timeout():
	explode()

func explode():
	#cria o objeto de explosao
	var explosion = explosionScene.instantiate() as Area2D
	#muda a posicao do objeto de explosao
	explosion.global_position = global_position
	#spawna o objeto de explosao
	game.add_child(explosion)
	#deleta a bomba
	queue_free()
