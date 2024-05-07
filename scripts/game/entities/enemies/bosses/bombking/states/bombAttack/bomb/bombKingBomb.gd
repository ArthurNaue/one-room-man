extends CharacterBody2D
class_name bombKingBomb

#variaveis
@onready var explosionScene = load("res://scenes/game/entities/enemies/bosses/bombking/bombAttack/bomb/explosion/bombKingBombExplosion.tscn")
@onready var game = get_tree().get_first_node_in_group("game")
var speed
var desiredLocation
var direction

func _ready():
	#muda o angulo para a direcao desejada
	look_at(desiredLocation)

func _physics_process(_delta):
	#muda a direcao da bomba
	direction = desiredLocation - position
	if direction.length() < 2:
		#explode a bomba
		explode()
	else:
		#aplica movimento na bomba
		velocity = direction.normalized() * speed

	move_and_slide()

#funcao que verifica se o objeto colidiu
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um player
	if area.is_in_group("player"):
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
