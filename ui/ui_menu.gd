extends Control

@onready var btn_resume: Button = %BResume
@onready var btn_quit: Button = %BQuit
@export var pause_handler: Node

func _ready():
	btn_resume.pressed.connect(func(): pause_handler.pause(false))
	btn_quit.pressed.connect(func(): get_tree().quit())
