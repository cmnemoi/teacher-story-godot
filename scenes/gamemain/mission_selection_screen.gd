extends Control

@onready var scroll_camera: Camera2D = $ScrollCamera
@export var scroll_power : int = 20

func _process(_delta: float) -> void:
	if visible:
		if Input.is_action_just_pressed("scroll_down"):
			scroll_camera.position.y += scroll_power
		elif Input.is_action_just_pressed("scroll_up"):
			scroll_camera.position.y -= scroll_power
