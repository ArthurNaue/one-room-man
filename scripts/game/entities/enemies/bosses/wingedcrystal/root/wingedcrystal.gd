extends CharacterBody2D
class_name WingedCrystal

#variaveis
@onready var direction = $direction

func _physics_process(_delta):
	#atualiza a direcao
	direction.Direction()
	#faz o player se mover
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
