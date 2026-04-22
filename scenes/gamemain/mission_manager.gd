extends Node

var current_mission_resource : MissionBase
var rng = RandomNumberGenerator.new()
const POSSIBLE_DIFFICULTIES : Array[int] = [0,1,2,3]
const DIFFICULTIES_WEIGHTS : Array[int] = [7,13,10,5]
const POSSIBLE_GOALS : Array[int] = [10,11,12,13,14,15,16]
const POSSIBLE_GOALS_FOR_X_ELEVES : Array[int] = [10,12,14,16]
var goals_weights : Array[int] = [7,10,9,6,2,0]


func _ready() -> void:
	ManagerList.mission_manager = self
	await get_tree().process_frame
	generate_mission_selection()

func update_mainscreen_ui():
	%MissionInfoContainer.update_objective_label(Global.get_text_for_mission_objective(current_mission_resource))
	%MissionInfoContainer.update_reward_label("[color=f07c46][b]%s[/b][/color] [img]uid://dfcgw32nv5d56[/img][font_size=12] [i](reste %s cours) [/i] [/font_size]"%[current_mission_resource.reward,current_mission_resource.ideal_max_lesson])


func generate_mission_selection():
	%MainGameScreen.hide()
	%MissionSelectionScreen.show()
	for child in %MissionSelectionInstanceContainer.get_children():
		if child is MissionSelectionInstance:
			var new_mission = make_new_random_mission()
			child.update_ui(new_mission)


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
	update_mainscreen_ui()

func reparent_labels(labels,new_parent):
	for label in labels:
		label.reparent(new_parent)

func make_new_random_mission():
	var new_resource = MissionBase.new()
	var difficulty = POSSIBLE_DIFFICULTIES[rng.rand_weighted(DIFFICULTIES_WEIGHTS)]
	var all_students = [0,1].pick_random()
	new_resource.classname = ["Sixième","Cinquième","Quatrième","Troisième","Seconde","Première","Terminale"].pick_random()+" " +["A","B","C","D","E","F","G","H","I","J","K"].pick_random()
	new_resource.matiere = ["Maths","Histoire-Géo","SVT","Physique","Français","Anglais","Musique"].pick_random()
	match difficulty:
		0: 
			if all_students:
				goals_weights = [2,10,5,0]
			else:
				goals_weights = [3,7,10,9,6,2,0]
			new_resource.goal_is_for_x_student = randi_range(1,2)
			new_resource.ideal_max_lesson = 6
			new_resource.absolute_max_lesson = 9
			new_resource.students = ManagerList.student_manager.generate_x_random_student(5)
			new_resource.reward = 40
		1:
			if all_students:

				goals_weights = [1,7,7,1]
			else:
				goals_weights = [2,4,8,9,5,2,0]
			new_resource.goal_is_for_x_student = randi_range(1,3)
			new_resource.ideal_max_lesson = 5
			new_resource.absolute_max_lesson = 7
			new_resource.students = ManagerList.student_manager.generate_x_random_student(5)
			new_resource.reward = 60
		2:
			if all_students:
				goals_weights = [0,4,12,4]
			else:
				goals_weights = [0,2,5,9,11,6,2]
			new_resource.goal_is_for_x_student = randi_range(2,4)
			new_resource.ideal_max_lesson = 4
			new_resource.absolute_max_lesson = 6
			new_resource.students = ManagerList.student_manager.generate_x_random_student(6)
			new_resource.reward = 90
		3:
			if all_students:
				goals_weights = [0,0,8,3]
			else:
				goals_weights = [0,0,2,4,7,6,2]
			new_resource.goal_is_for_x_student = randi_range(3,5)
			new_resource.ideal_max_lesson = 3
			new_resource.absolute_max_lesson = 4
			new_resource.students = ManagerList.student_manager.generate_x_random_student(8)
			new_resource.reward = 120
	
	new_resource.goal = POSSIBLE_GOALS[rng.rand_weighted(goals_weights)]
	if randi_range(0,1000000) == 8:
		new_resource.goal = 2 #Enjoy the free win, you earned it
	new_resource.difficulty = difficulty
	if all_students:
		new_resource.goal_is_for_x_student = -1
	return new_resource
