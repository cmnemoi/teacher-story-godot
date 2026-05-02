extends Node2D

func set_camera_offset(offset : Vector2):
	$Camera2D.offset= offset

func _process(delta: float) -> void:
	if Global.IS_DEBUG:
		var direction = Input.get_vector("debug_camera_left","debug_camera_right","debug_camera_up","debug_camera_down")
		$Camera2D.offset += direction * delta * 80
