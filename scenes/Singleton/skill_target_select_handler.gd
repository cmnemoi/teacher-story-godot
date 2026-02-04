extends Node

##Make the player select a table, then Returns an array of students at the selected table
func select_table()-> Array[Student]:
	await get_tree().create_timer(4).timeout
	return []
