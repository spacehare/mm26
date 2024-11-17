extends Node

@export var menu: Control
@export var quad: MeshInstance3D

func _ready():
	pause(false)

func _input(event):
	if event.is_action_pressed("game_pause"):
		pause(not get_tree().paused)

func pause(state: bool):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if state else Input.MOUSE_MODE_CAPTURED
	if menu:
		menu.visible = state
	if quad:
		quad.mesh.material.set_shader_parameter('paused', state)
	get_tree().paused = state