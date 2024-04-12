extends State
class_name PlayerWalkState

#variaveis
@export var speed: float

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = get_tree().get_first_node_in_group("player").get_node("sprite")

#faz um Vector2 zerado
var inputVector = Vector2.ZERO

func Physics_Update(_delta):
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
