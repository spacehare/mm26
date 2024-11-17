extends Node

func _ready():
	if not OS.is_debug_build():
		queue_free()

func _input(event):
	if event.is_action_pressed('dev_quit'):
		get_tree().quit()
	elif event.is_action_pressed('dev_restart'):
		get_tree().reload_current_scene()