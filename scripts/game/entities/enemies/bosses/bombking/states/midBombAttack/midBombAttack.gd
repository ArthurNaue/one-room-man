extends State
class_name bombKingMidBombAttack

#variaveis
@export var moveSpeed: int
@onready var enemy = get_parent().get_parent()
@onready var midBombAttackSound = $midBombAttackSound

func Physics_Update(_delta):
	#define a direcao que o player tem que ir
	var direction = (Enemies.mid - enemy.global_position)
	#verifica a distancio entre o player e o meio
	if direction.length() < 1:
		#faz o inimigo parar
		enemy.velocity = Vector2.ZERO
		#muda a animacao para a de parado
		enemy.get_node("sprite").animation = "midBombAttack"
	else:
		#faz o inimigo ir ate o meio
		enemy.velocity = direction.normalized() * moveSpeed

func roundExplosion():
	Enemies.shoot(enemy.global_position, Vector2(152, 242), "bomb", 100)
	Enemies.shoot(enemy.global_position, Vector2(152, 60), "bomb", 100)
	Enemies.shoot(enemy.global_position, Vector2(242, 152), "bomb", 100)
	Enemies.shoot(enemy.global_position, Vector2(60, 152), "bomb", 100)
	Transitioned.emit(self, "follow")

func _on_sprite_animation_finished():
	#toca o som do ataque
	midBombAttackSound.play()
	#joga as bombas
	roundExplosion()
