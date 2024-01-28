extends Node2D
class_name Bomb

@export var weaponCooldown: float
@export var projectileScene: PackedScene
@onready var player = get_parent().get_parent()
@onready var anim = $anim

func _ready():
	#reseta o cooldown
	player.weaponCooldown = 2
	#toca a animacao de ficar parado
	anim.play("idle")

func _process(delta:float):
	#verifica se o botao esquerdo do mouse foi clicado
	if Input.is_action_pressed("mouse_left"):
		#verifica se o cooldown acabou
		if player.weaponCooldown <= 0:
			#toca a animacao de ataque
			anim.play("attack")
			#atira a bomba
			Throw()

func Throw():
	#cria o projetil
	var projectile = projectileScene.instantiate() as CharacterBody2D
	projectile.global_position = global_position
	player.get_parent().add_child(projectile)
	#reseta o cooldown
	player.weaponCooldown = weaponCooldown

func _on_anim_animation_finished(attack):
	anim.play("idle")
