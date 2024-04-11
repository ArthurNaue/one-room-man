extends CharacterBody2D
class_name Crystal

#variaveis
var x: float
var y: float

func _physics_process(_delta):
	x = global_position.x
	y = global_position.y

func _on_shoot_timer_timeout():
	#atira os cristais
	shoot_crystal(Vector2((x + 1), y))
	shoot_crystal(Vector2((x - 1), y))
	shoot_crystal(Vector2(x, (y + 1)))
	shoot_crystal(Vector2(x, (y - 1)))
	shoot_crystal(Vector2((x + 1), (y + 1)))
	shoot_crystal(Vector2((x - 1), (y - 1)))
	shoot_crystal(Vector2((x + 1), (y - 1)))
	shoot_crystal(Vector2((x - 1), (y + 1)))

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

#funcao de atirar crystal
func shoot_crystal(destination: Vector2):
	Enemies.shoot(global_position, destination, "crystalBullet", 100)
