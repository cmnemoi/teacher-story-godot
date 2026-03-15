extends Node
@onready var heads_container: TextureRect = $HeadsContainer
@onready var classname: RichTextLabel = $ClassName


func _process(_delta: float) -> void:
	if ManagerList.mission_manager == null:
		return
	
	var mission = ManagerList.mission_manager.current_mission_resource
	if mission != null:
		heads_container.texture = Global.demon_heads[mission.difficulty+1]
		classname.text = "[b]" + mission.classname + "[/b]"
	else:
		heads_container.texture = Global.demon_heads[0]
		classname.text = "En Congés"
