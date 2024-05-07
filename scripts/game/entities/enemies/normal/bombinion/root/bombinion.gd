extends CharacterBody2D
class_name Bombinion

#variaveis
@onready var player = get_tree().get_first_node_in_group("player")
@onready var game = get_tree().get_first_node_in_group("game")
@onready var explosionScene = load("res://scenes/game/entities/enemies/bosses/bombking/bombAttack/bomb/explosion/bombKingBombExplosion.tscn")

const moveSpeed = 80

func _physics_process(_delta):
	#define a distancia entre o inimigo e o player
	var distance = Enemies.getDistance(player.global_position, global_position)
	#verifica a distancia entre o player e o inimigo
	if distance.length() < 30:
		#explode
		explode()
	else:
		#faz o inimigo seguir o player
		Enemies.follow(distance, self, moveSpeed)
	

	move_and_slide()

#funcao de verificar se houve uma colisao
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um player
	if area.is_in_group("player"):
		#verifica se pode sofrer dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 1
			#aplica 1 de dano
			area.Damage(attack)

func explode():
	#cria o objeto de explosao
	var explosion = explosionScene.instantiate() as Area2D
	#muda a posicao do objeto de explosao
	explosion.global_position = global_position
	#spawna o objeto de explosao
	game.add_child(explosion)
	#diminui um dos inimigos vivos
	game.entitiesAlive -= 1
	#deleta a bomba
	queue_free()
