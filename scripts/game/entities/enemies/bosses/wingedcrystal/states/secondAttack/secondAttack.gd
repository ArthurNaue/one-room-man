extends State
class_name wingedCrystalSecondAttackState

#variaveis
@onready var enemy = get_parent().get_parent()

func Enter():
	enemy.get_node("attackAnim").stop()
