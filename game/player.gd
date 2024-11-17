extends CharacterBody3D

@export var avatar: Node3D
@export var cam: Camera3D
@export var gimbal: SpringArm3D
@export var jump_height := 6.
@export var max_jumps: int = 2
@onready var jumps = max_jumps
@export var acceleration := 10.
@export var h_accel := .1
@export var h_decel := .1
@export var h_speed := 6.

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	if is_on_floor():
		jumps = max_jumps
	# variable jump
	elif not Input.is_action_pressed('act_jump'):
		velocity.y -= 2 * gravity * delta
		
	
	var input_dir := Input.get_vector('act_left', 'act_right', 'act_forward', 'act_back')
	var dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() \
	# move appropriately regardless of camera angle
	.rotated(Vector3.UP, gimbal.rotation.y).normalized()

	if dir:
		velocity.x = move_toward(velocity.x, dir.x * h_speed, h_accel)
		velocity.z = move_toward(velocity.z, dir.z * h_speed, h_accel)
	else:
		velocity.x = move_toward(velocity.x, 0, h_decel)
		velocity.z = move_toward(velocity.z, 0, h_decel)

	var cam_input_dir = Input.get_vector('cam_left', 'cam_right', 'cam_up', 'cam_down')
	gimbal.rotation.x += cam_input_dir.y * A.settings.joy_sensitivty
	gimbal.rotation.y += cam_input_dir.x * A.settings.joy_sensitivty

	# jump
	if Input.is_action_just_pressed('act_jump') and jumps > 0:
		jumps -= 1
		velocity.y = sqrt(gravity * jump_height)
	else:
		velocity.y -= gravity * delta

	# face avatar toward movement
	# avatar.look_at(avatar.global_position + velocity, Vector3.UP)
	# avatar.rotation.y = lerp(avatar.rotation.y, atan2(-velocity.x, -velocity.z), .1)
	# avatar.transform = avatar.transform.interpolate_with(avatar.transform.looking_at(velocity), .1)


	move_and_slide()