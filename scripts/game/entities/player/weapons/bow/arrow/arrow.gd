extends CharacterBody2D
class_name UpgradedArrow

#variaveis
@onready var direction = (get_global_mouse_position() - position).normalized()
var speed: int
var damage: int

func _ready():
	#muda o angulo para a direcao do mouse
	look_at(get_global_mouse_position())

func _physics_process(_delta):
	#aplica movimento na bala
	velocity = direction * speed
	move_and_slide()

#funcao que verifica se o objeto colidiu
func _on_hitbox_area_entered(area):
	#verifica se o objeto colidido e um inimigo
	if area.is_in_group("enemy"):
		#verifica se tem a funcao de tomar dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = damage
			#aplica o dano 
			area.Damage(attack)
			#se auto destroi
			queue_free()

func _on_despawn_timer_timeout():
	#se auto destroi
	queue_free()
