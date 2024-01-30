extends StaticBody2D
class_name Coin

func _on_hitbox_area_entered(area):
	if area.is_in_group("player"):
		get_parent().addCoin()
		queue_free()
