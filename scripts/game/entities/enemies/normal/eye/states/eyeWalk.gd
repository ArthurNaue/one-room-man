extends State
class_name EyeWalk

#variaveis
@onready var enemy = get_parent().get_parent()
@export var moveSpeed := 10
var player: CharacterBody2D
var moveDirection: Vector2
var wanderTime: float

func Enter():
	#muda a animacao para a de andar
	enemy.get_node("sprite").animation = "walk"
	#toca a animacao de andar
	enemy.get_node("sprite").play()
	#define a variavel do player
	player = get_tree().get_first_node_in_group("player")
	#executa a funcao de randomizar a direcao do inimigo
	Randomize_Wander()
	
	
func Update(delta : float):
	#verifica se o tempo de espera para se mover e maior que 0
	if wanderTime > 0:
		#diminui o tempo de espera por delta
		wanderTime -= delta
	else:
		#executa a funcao de randomizar a direcao do inimigo
		Randomize_Wander()

func Physics_Update(_delta):
	#verifica se o inimigo existe
	if enemy:
		#faz o inimigo se mover na direcao selecionada
		enemy.velocity = moveDirection * moveSpeed
	
	#define a direcao como a diferenca entre a posicao do player e do inimigo
	var direction = player.global_position - enemy.global_position
	
	#verifica se a distancia e menor que 60
	if direction.length() < 60:
		#muda o estado para seguindo
		Transitioned.emit(self, "follow")

#funcao de randomizar a direcao do inimigo
func Randomize_Wander():
	#randomiza a direcao que o inimigo tem que ir
	moveDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	#reseta o tempo de espera para o inimigo se mover
	wanderTime = randf_range(1, 3)
