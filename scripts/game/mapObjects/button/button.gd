extends StaticBody2D
class_name RoundButton

var oncooldown: bool
@onready var interactText = $interactText
@onready var sprite = $sprite
@onready var cooldownTimer = $cooldownTimer

func _process(_delta):
	if interactText.visible == true:
		if Input.is_action_just_pressed("E"):
			buttonPressed()

func _on_hitbox_area_entered(area):
	if oncooldown == false:
		if area.is_in_group("player"):
			interactText.visible = true

func _on_hitbox_area_exited(area):
	if area.is_in_group("player"):
		interactText.visible = false

func buttonPressed():
	if oncooldown == false:
		interactText.visible = false
		oncooldown = true
		sprite.play()
		cooldownTimer.start()
		get_parent().nextRound()

func _on_cooldown_timer_timeout():
	oncooldown = false
	sprite.animation = "unpressed"
	sprite.play()

func _on_sprite_animation_finished():
	if sprite.animation == "unpressed":
		sprite.animation = "pressed"
