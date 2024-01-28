extends Node2D
class_name Bomb

@export var explosionScene: PackedScene
@onready var weaponsNode = get_parent()
@onready var player = get_parent().get_parent()
@onready var anim = $anim

func _ready():
	#reseta o cooldown
	player.weaponCooldown = 5
	#reseta a animacao
	anim.play("idle")

func _process(delta:float):
	#verifica se o botao esquerdo do mouse foi clicado
	if Input.is_action_pressed("mouse_left"):
		#verifica se o cooldown acabou
		if player.weaponCooldown <= 0:
			#atira a bomba
			anim.play("attack")
			weaponsNode.attacking = true

#funcao realizada ao fim da animacao de ataque
func _on_anim_animation_finished(attack):
	#explode
	explode()

#funcao de explodir
func explode():
	#cria o objeto de explosao
	var explosion = explosionScene.instantiate() as StaticBody2D
	explosion.global_position = global_position
	player.get_parent().add_child(explosion)
	#reseta a animacao
	anim.play("idle")
	#reseta o cooldown
	player.weaponCooldown = 5
	weaponsNode.attacking = false
	$areaCol/col.disabled = true

func _on_area_col_area_entered(area):
	#verifica se a colisao ocorreu com um inimigo
	if area.is_in_group("enemy"):
		#explode
		explode()
