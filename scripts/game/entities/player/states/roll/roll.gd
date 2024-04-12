extends State
class_name PlayerRollState

#variaveis
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = player.get_node("sprite")
@onready var col = player.get_node("hitbox/col")
@onready var rollTimer = $rollTimer

var direction: Vector2

func Enter():
	#troca a animacao para a de rolar
	sprite.animation = "roll"
	#toca a animacao
	sprite.play()
	#desabilita a colisao do player
	col.disabled = true
	#inicia o timer de roll
	rollTimer.start()
	#faz a variavel da direcao do roll
	direction = player.rollDirection
	#ajusta a velocidade do player
	player.speed = 250

func Exit():
	#habilita a colisao do player
	col.disabled = false

func Physics_Update(_delta):
	#altera a velocidade do player baseado na direcao 
	player.velocity = direction * player.speed

#funcao que executa no fim do timer do roll
func _on_roll_timer_timeout():
	#muda o estado para o de andar
	Transitioned.emit(self, "walk")
