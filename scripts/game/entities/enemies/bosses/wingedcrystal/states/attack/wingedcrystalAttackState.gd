extends State
class_name wingedCrystalAttackState

#variaveis
@onready var enemy = get_parent().get_parent()
@onready var enemyHealth = enemy.get_node("health")
@onready var attackAnim = enemy.get_node("attackAnim")

var pos: Vector2
var bulletPosition: Vector2
var bulletDirection: Vector2

func Enter():
	#atualiza a posicao do inimigo
	pos = enemy.global_position
	#ataca
	attack()

func Update(_delta):
	#verifica se a vida do inimigo esta na metade
	if enemyHealth.health <= (enemyHealth.maxHealth * 0.75):
		Transitioned.emit(self, "secondAttack")

func attack():
	#seleciona o braco
	var arm = randi_range(1, 4)
	match arm:
		1:
			bulletPosition = Vector2(pos.x - 8, pos.y - 4)
			bulletDirection = Vector2((bulletPosition.x - 1), (bulletPosition.y - 1))
			attackAnim.play("topLeft")
		2:
			bulletPosition = Vector2(pos.x + 8, pos.y - 4)
			bulletDirection = Vector2((bulletPosition.x + 1), (bulletPosition.y - 1))
			attackAnim.play("topRight")
		3:
			bulletPosition = Vector2(pos.x - 8, pos.y + 4)
			bulletDirection = Vector2((bulletPosition.x - 1), (bulletPosition.y + 1))
			attackAnim.play("bottomLeft")
		4:
			bulletPosition = Vector2(pos.x + 8, pos.y + 4)
			bulletDirection = Vector2((bulletPosition.x + 1), (bulletPosition.y + 1))
			attackAnim.play("bottomRight")

func _on_attack_anim_animation_finished(_anim_name):
	attack()

func _on_attack_anim_animation_started(_anim_name):
	Enemies.shoot(bulletPosition, bulletDirection, "crystalBullet", 80)
