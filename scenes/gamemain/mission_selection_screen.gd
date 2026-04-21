extends Control

@onready var scroll_camera: Camera2D = $ScrollCamera
@export var scroll_power : int = 20
var base_cam_pos : Vector2

func _ready():
	base_cam_pos = scroll_camera.position

func _process(_delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("scroll_down"):
			scroll_camera.position.y += scroll_power
		elif Input.is_action_just_pressed("scroll_up"):
			scroll_camera.position.y -= scroll_power
	else:
		scroll_camera.position = base_cam_pos
