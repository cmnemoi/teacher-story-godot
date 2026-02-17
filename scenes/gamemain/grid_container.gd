extends GridContainer
@export var lines = 3
@export var offset_y = 128
@export var offset_x = 128

func _on_sort_children() -> void:
	var children = get_children()
	
	for i in len(children):
		var column = i%columns
		var line = i/columns
		print(line," ",column)
		var pos_y = ((size.y/lines) * line) + offset_y * column
		var pos_x =  ((size.x/columns)*column) + offset_x * (lines-line)

		children[i].position.x = pos_x - (size.x)
		children[i].position.y = pos_y - (size.y/6)
