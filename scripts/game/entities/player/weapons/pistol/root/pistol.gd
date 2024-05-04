extends Node2D
class_name Pistol

#variaveis
@onready var bulletScene = load("res://scenes/game/entities/player/weapons/pistol/bullet/pistolBullet.tscn")
@onready var upgradedBulletScene = load("res://scenes/game/entities/player/weapons/pistol/upgradedBullet/upgradedBullet.tscn")

@onready var player = get_parent().get_parent()
@onready var anim = $anim
@onready var shootSound = $shootSound

const weaponCooldown = 1

var upgraded: bool

func _ready():
	#tira o upgrade da arma
	upgraded = false
	#reseta o cooldown da arma
	player.weaponCooldown = weaponCooldown
	#toca a animacao da arma parada
	anim.play("idle")

func _process(_delta):
	#verifica se o player clicou com o botao esquerdo do mouse
	if Input.is_action_pressed("mouse_left"):
		#verifica se o cooldown acabou
		if player.weaponCooldown <= 0:
			#toca a animacao de ataque
			anim.play("attack")
			#verifica se a arma ta melhorada
			if upgraded == false:
				#atira
				Fire()
			else:
				#atira o tiro melhorado
				upgradedFire()

#funcao que ativa quando a animacao de ataque termina
func _on_anim_animation_finished(_attack):
	#toca a animacao da arma parada
	anim.play("idle")

#funcao que faz o player atirar
func Fire():
	#toca o som de tiro
	shootSound.play()
	#pega o node da bala
	var bullet = bulletScene.instantiate() as CharacterBody2D
	#define a posicao do node da bala para a posicao da pistola
	bullet.global_position = global_position
	#spawna a bala
	player.get_parent().add_child(bullet)
	#ajusta o cooldown
	player.weaponCooldown = weaponCooldown
	
#funcao que faz o player atirar com upgrade
func upgradedFire():
	#toca o som de tiro
	shootSound.play()
	#pega o node da bala
	var bullet = upgradedBulletScene.instantiate() as CharacterBody2D
	#define a posicao do node da bala para a posicao da pistola
	bullet.global_position = global_position
	#spawna a bala
	player.get_parent().add_child(bullet)
	#ajusta o cooldown
	player.weaponCooldown = weaponCooldown
