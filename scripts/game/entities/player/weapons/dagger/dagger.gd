extends Node2D
class_name Dagger

@onready var weaponsNode = get_parent()
@onready var player = get_parent().get_parent()
@onready var anim = $anim

func _ready():
	player.weaponCooldown = 1
	anim.play("idle")

func _process(delta:float):
	if Input.is_action_pressed("mouse_left"):
		if player.weaponCooldown <= 0:
			anim.play("attack")
			weaponsNode.attacking = true

#funcao de verificar se a hitbox colidiu
func _on_hitbox_area_entered(area):
	#verifica se a area colidida e um inimigo
	if area.is_in_group("enemy"):
		#verifica se pode sofrer dano
		if area.has_method("Damage"):
			#define os parametros do ataque
			var attack = Attack.new()
			attack.attackDamage = 3
			#aplica 3 de dano
			area.Damage(attack)

func _on_anim_animation_finished(attack):
	player.weaponCooldown = 1
	anim.play("idle")
	weaponsNode.attacking = false
