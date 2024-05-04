extends Node2D
class_name Bow

#variaveis
@onready var arrowScene = load("res://scenes/game/entities/player/weapons/bow/arrow/arrow.tscn")
@onready var upgradedArrowScene = load("res://scenes/game/entities/player/weapons/bow/upgradedArrow/upgradedArrow.tscn")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $sprite
@onready var bowAudio = $bowAudio

const bowCooldown = 1

var upgraded: bool
var charge: int

func _ready():
	#tira o upgrade da arma
	upgraded = false
	#define o carregamento para o valor padrao
	charge = 0

func _process(_delta):
	#verifica se o botao esquerdo do mouse foi pressionado
	if Input.is_action_pressed("mouse_left"):
		#verifica se o cooldown do player acabou
		if player.weaponCooldown <= 0:
			#muda a animacao para a de carregar
			sprite.animation = "charge"
			#muda o frame da animacao para o inicial
			sprite.frame = 0
			#carrega o arco
			charge += 2
			#verifica se o carregamento ta entre 200 e 300
			if charge > 200 && charge < 300:
				#muda o frame da animacao de carregamento do arco
				sprite.frame = 1
			#verifica se o carregamento ta no maximo
			if charge > 300:
				#muda o frame da animacao de carregamento do arco
				sprite.frame = 2
				#trava o valor do carregamento em 300
				charge = 300

	if Input.is_action_just_released("mouse_left"):
		#verifica se o cooldown do arco acabou
		if player.weaponCooldown <= 0:
			#toca o som do arco
			bowAudio.play()
			#verifica se a arma ta melhorada
			if upgraded == false:
				#atira
				Fire()
			else:
				#atira o tiro melhorado
				upgradedFire()
			sprite.animation = "idle"
			charge = 0

#funcao que faz o player atirar
func Fire():
	#pega o node da flecha
	var arrow = arrowScene.instantiate() as CharacterBody2D
	#define a posicao do node da flecha para a posicao do arco
	arrow.global_position = global_position
	#define a velocidade da flecha
	arrow.speed = charge
	#define o dano da flecha
	if charge >= 300:
		arrow.damage = 3
	elif charge >= 200 && charge < 300:
		arrow.damage = 2
	else: 
		arrow.damage = 1

	#spawna a flecha
	player.get_parent().add_child(arrow)
	#ajusta o cooldown
	player.weaponCooldown = bowCooldown

func upgradedFire():
	#pega o node da flecha melhorada
	var upgradedArrow = upgradedArrowScene.instantiate() as CharacterBody2D
	#define a posicao do node da flecha melhorada para a posicao do arco
	upgradedArrow.global_position = global_position
	#define a velocidade da flecha melhorada
	upgradedArrow.speed = charge
	#define o dano da flecha melhorada
	if charge >= 300:
		upgradedArrow.damage = 5
	elif charge >= 200 && charge < 300:
		upgradedArrow.damage = 4
	else: 
		upgradedArrow.damage = 3
	
	#spawna a flecha melhorada
	player.get_parent().add_child(upgradedArrow)
	#ajusta o cooldown
	player.weaponCooldown = bowCooldown
