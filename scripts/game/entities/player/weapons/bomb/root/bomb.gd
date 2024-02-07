extends Node2D
class_name Bomb

@export var weaponCooldown: float
@export var projectileScene: PackedScene
@export var upgradedProjectileScene: PackedScene
@onready var player = get_parent().get_parent()
@onready var anim = $anim
var upgraded: bool

func _ready():
	upgraded = false
	#reseta o cooldown
	player.weaponCooldown = 2
	#toca a animacao de ficar parado
	anim.play("idle")

func _process(_delta):
	#verifica se o botao esquerdo do mouse foi clicado
	if Input.is_action_pressed("mouse_left"):
		#verifica se o cooldown acabou
		if player.weaponCooldown <= 0:
			if upgraded == false:
				#toca a animacao de ataque
				anim.play("attack")
				#atira a bomba
				Throw()
			else:
				upgradedThrow()

func Throw():
	#cria o projetil
	var projectile = projectileScene.instantiate() as CharacterBody2D
	projectile.global_position = global_position
	player.get_parent().add_child(projectile)
	#reseta o cooldown
	player.weaponCooldown = weaponCooldown

func upgradedThrow():
	#cria o projetil
	var projectile = upgradedProjectileScene.instantiate() as CharacterBody2D
	projectile.global_position = global_position
	player.get_parent().add_child(projectile)
	#reseta o cooldown
	player.weaponCooldown = weaponCooldown

func _on_anim_animation_finished(_attack):
	anim.play("idle")
