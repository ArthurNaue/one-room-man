extends State
class_name PlayerWalkState

#variaveis
@onready var player = get_tree().get_first_node_in_group("player")
@onready var speed =  player.speed
@onready var sprite = player.get_node("sprite")
@onready var inputVector = player.inputVector
@onready var rollCooldown = 2
@onready var rollCooldownBar = player.get_node("rollCooldownBar")

func Enter():
	#ajusta o cooldown
	rollCooldown = 2
	#faz a barra de cooldown do roll ficar visivel
	rollCooldownBar.visible = true
	#ajusta a velocidade do player
	speed = 100

func Physics_Update(_delta):
	#ajusta a barra de cooldown do roll
	rollCooldownBar.value = rollCooldown
	#diminui o cooldown do roll
	rollCooldown -= _delta
	
	#verifica se o cooldown do roll acabou
	if rollCooldown <= 0:
		#faz a barra de cooldown do roll ficar invisivel
		rollCooldownBar.visible = false

	#adiciona a direcao do player ao Vector2
	inputVector.x = Input.get_action_strength("D") - Input.get_action_strength("A")
	inputVector.y = Input.get_action_strength("S") - Input.get_action_strength("W")
	#estabiliza os numeros do Vector2
	inputVector = inputVector.normalized()
	
	#verifica se tem alguma direcao para ir
	if inputVector:
		#altera a velocidade do player baseado na direcao 
		player.velocity = inputVector * speed
		#muda a animacao para a de andar
		sprite.animation = "walk"
	else:
		#faz o player parar de andar
		player.velocity = Vector2.ZERO
		#muda a animacao para a de parado
		sprite.animation = "idle"

	#muda a direcao da sprite com base na direcao do player
	if Input.is_action_just_pressed("D"):
		sprite.flip_h = false
	elif Input.is_action_just_pressed("A"):
		sprite.flip_h = true
	
	#verifica se o player clicou espaco
	if Input.is_action_just_pressed("space"):
		#verifica se o cooldown do roll acabou
		if rollCooldown <= 0:
			#define a direcao do roll
			player.rollDirection = inputVector
			#muda o estado para o de roll
			Transitioned.emit(self, "roll")
