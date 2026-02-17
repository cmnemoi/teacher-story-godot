extends TextureRect



func _on_resized() -> void:
	offset_bottom = -1* %BottomBorder.size.y+1

func _ready() -> void:
	_on_resized()
