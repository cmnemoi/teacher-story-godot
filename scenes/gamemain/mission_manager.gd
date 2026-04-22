extends Node

var current_mission_resource : MissionBase
var rng = RandomNumberGenerator.new()
const POSSIBLE_DIFFICULTIES : Array[int] = [0,1,2,3]
const DIFFICULTIES_WEIGHTS : Array[int] = [7,13,10,5]
const POSSIBLE_GOALS : Array[int] = [10,11,12,13,14,15,16]
var goals_weights : Array[int] = [7,10,9,6,2,0]


func _ready() -> void:
	ManagerList.mission_manager = self
	await get_tree().process_frame
	generate_mission_selection()

func update_mainscreen_ui():
	%MissionInfoContainer.update_objective_label("Note minimum [color=%s] [b]  %s/20 [/b] [/color]"%[Global.get_color_for_note(current_mission_resource.goal),current_mission_resource.goal])
	%MissionInfoContainer.update_reward_label("[color=f07c46][b]%s[/b][/color] [img]uid://dfcgw32nv5d56[/img][font_size=12] [i](reste %s cours) [/i] [/font_size]"%[current_mission_resource.reward,current_mission_resource.ideal_max_lesson])

func generate_mission_selection():
	for child in %MissionSelectionInstanceContainer.get_children():
		if child is MissionSelectionInstance:
			var new_mission = make_new_random_mission()
			child.update_ui(new_mission)
	%MainGameScreen.hide()
	%MissionSelectionScreen.show()

func mission_selected(resource,name_labels,note_labels,caractere_labels):
	current_mission_resource = resource
	var sm = ManagerList.student_manager
	sm.students_resources = resource.students
	sm.name_info_labels = name_labels
	sm.note_info_labels = note_labels
	sm.caractere_info_labels = caractere_labels
	reparent_labels(Global.interleave_arrays(name_labels,note_labels),%StudentInfoContainer)
	sm.assign_students_to_random_desk()
	%MainGameScreen.show()
	%MissionSelectionScreen.hide()

func reparent_labels(labels,new_parent):
	for label in labels:
		label.reparent(new_parent)

func make_new_random_mission():
	var new_resource = MissionBase.new()
	var difficulty = POSSIBLE_DIFFICULTIES[rng.rand_weighted(DIFFICULTIES_WEIGHTS)]
	var lenghty = [0,1].pick_random()
	new_resource.classname = ["Sixième","Cinquième","Quatrième","Troisième","Seconde","Première","Terminale"].pick_random()+" " +["A","B","C","D","E","F","G","H","I","J","K"].pick_random()
	new_resource.matiere = ["Maths","Histoire-Géo","SVT","Physique","Français","Anglais","Musique"].pick_random()
	match difficulty:
		0: 
			if lenghty:
				new_resource.ideal_max_lesson = 6
				new_resource.absolute_max_lesson = 9
				goals_weights = [2,5,10,13,5,3,0]
			else:
				new_resource.ideal_max_lesson = 5
				new_resource.absolute_max_lesson = 8
				goals_weights = [3,7,10,9,6,2,0]
			new_resource.students = ManagerList.student_manager.generate_x_random_student(4)
			new_resource.reward = 40
		1:
			if lenghty:
				new_resource.ideal_max_lesson = 5
				new_resource.absolute_max_lesson = 7
				goals_weights = [1,3,7,10,7,3,1]
			else:
				new_resource.ideal_max_lesson = 4
				new_resource.absolute_max_lesson = 6
				goals_weights = [2,4,8,9,5,2,0]
			new_resource.students = ManagerList.student_manager.generate_x_random_student(5)
			new_resource.reward = 60
		2:
			if lenghty:
				new_resource.ideal_max_lesson = 4
				new_resource.absolute_max_lesson = 6
				goals_weights = [0,1,4,9,12,7,4]
			else:
				new_resource.ideal_max_lesson = 3
				new_resource.absolute_max_lesson = 4
				goals_weights = [0,2,5,9,11,6,2]
			new_resource.students = ManagerList.student_manager.generate_x_random_student(6)
			new_resource.reward = 90
		3:
			if lenghty:
				new_resource.ideal_max_lesson = 3
				new_resource.absolute_max_lesson = 4
				goals_weights = [0,0,0,3,8,6,3]
			else:
				new_resource.ideal_max_lesson = 2
				new_resource.absolute_max_lesson = 3
				goals_weights = [0,0,2,4,7,6,2]
			new_resource.students = ManagerList.student_manager.generate_x_random_student(7)
			new_resource.reward = 120
	
	new_resource.goal = POSSIBLE_GOALS[rng.rand_weighted(goals_weights)]
	if randi_range(0,1000000) == 8:
		new_resource.goal = 2 #Enjoy the free win, you earned it
	new_resource.difficulty = difficulty
	return new_resource
