extends Node2D
class_name demoEndScreen

func _on_replay_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/root/game.tscn")