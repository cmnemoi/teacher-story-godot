extends CPUParticles2D

var parent

func _ready() -> void:
	parent = get_parent()
	self.global_position = parent.global_position + Vector2(parent.size.x/2,0)

func _process(_delta: float) -> void:
	self.global_position = parent.global_position + Vector2(parent.size.x/2,(parent.max_value-parent.value) * 2.5 + 5)
