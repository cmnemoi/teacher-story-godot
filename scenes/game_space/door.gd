extends Sprite2D

const OPEN_SPRITE = preload("uid://caqs2hrhdkm3s")
const CLOSED_SPRITE = preload("uid://doh2q7lhnt10a")
func open():
	self.texture = OPEN_SPRITE

func close():
	self.texture =  CLOSED_SPRITE

func _process(_delta: float) -> void:
	if Global.IS_DEBUG:
		if Input.is_action_just_pressed("debug"):
			open()
		elif Input.is_action_just_pressed("debug2"):
			close()
