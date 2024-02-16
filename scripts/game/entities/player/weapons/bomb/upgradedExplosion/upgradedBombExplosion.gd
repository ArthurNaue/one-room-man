extends StaticBody2D
class_name UpgradedBombExplosion

@onready var explosionSound = $explosionSound

func _ready():
	explosionSound.play()

func _on_hitbox_area_entered(area):
	if area.is_in_group("enemy"):
		#verifica se pode sofrer dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 6
			#aplica 6 de dano
			area.Damage(attack)

func _on_anim_animation_finished(_explosion):
	queue_free()
