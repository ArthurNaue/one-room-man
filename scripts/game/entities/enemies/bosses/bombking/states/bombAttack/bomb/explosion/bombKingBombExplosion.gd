extends Area2D
class_name bombKingBombExplosion

#variaveis
@onready var explosionSound = $explosionSound

func _ready():
	#toca o som de explosao
	explosionSound.play()

#verifica se animacao de explosao acabou
func _on_anim_animation_finished(_explode):
	#deleta a explosao
	queue_free()

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
