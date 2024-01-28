extends Marker2D
class_name DamageIndicatorComponent

func popup(damage):
	$damageText.text = str(damage)
