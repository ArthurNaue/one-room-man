extends ProgressBar
class_name HealthBar

@export var health: HealthComponent

func _ready():
	max_value = health.health
	value = health.health
