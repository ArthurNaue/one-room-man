extends CharacterBody2D
class_name EnemyBullet

#variaveis
@export var speed: int
@onready var direction = (get_tree().get_first_node_in_group("player").global_position - position).normalized()

func _ready():
	#muda o angulo para a direcao do mouse
	look_at(get_tree().get_first_node_in_group("player").global_position)

func _physics_process(_delta):
	#aplica movimento na bala
	velocity = direction * speed
	move_and_slide()

#funcao que verifica se o objeto colidiu
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um player
	if area.is_in_group("player"):
		#verifica se tem a funcao de tomar dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 1
			#aplica o dano 
			area.Damage(attack)
			#se auto destroi
			queue_free()

func _on_despawn_timer_timeout():
	queue_free()
