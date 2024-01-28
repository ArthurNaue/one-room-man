extends Node2D
class_name Pistol

@export var bulletScene: PackedScene
@onready var player = get_parent().get_parent()
@onready var anim = $anim

func _ready():
	player.weaponCooldown = 0.5
	anim.play("idle")

func _process(delta: float):
	if Input.is_action_pressed("mouse_left"):
		if player.weaponCooldown <= 0:
			anim.play("attack")
			Fire()

func _on_anim_animation_finished(attack):
	anim.play("idle")

#funcao que faz o player atirar
func Fire():
	#pega o node da bala
	var bullet = bulletScene.instantiate() as CharacterBody2D
	#define a posicao do node da bala para a posicao da pistola
	bullet.global_position = global_position
	#spawna a bala
	player.get_parent().add_child(bullet)
	#ajusta o cooldown
	player.weaponCooldown = 0.5
