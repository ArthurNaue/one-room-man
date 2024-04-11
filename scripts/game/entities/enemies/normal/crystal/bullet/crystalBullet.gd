extends CharacterBody2D
class_name CrystalBullet

#variaveis
var speed
var desiredLocation
var direction

func _ready():
	#muda a direcao da bala
	direction = (desiredLocation - position).normalized()
	#muda o angulo para o destino
	look_at(desiredLocation)

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
