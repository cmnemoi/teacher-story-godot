extends Node

var current_mission_resource : MissionBase
var rng = RandomNumberGenerator.new()
const POSSIBLE_DIFFICULTIES : Array[int] = [0,1,2,3]
const DIFFICULTIES_WEIGHTS : Array[int] = [7,13,10,5]
const POSSIBLE_GOALS : Array[int] = [10,11,12,13,14,15,16]
var goals_weights : Array[int] = [7,10,9,6,2,0]


func _ready() -> void:
	ManagerList.mission_manager = self
	make_new_random_mission()

func make_new_random_mission():
	var new_resource = MissionBase.new()
	var difficulty = POSSIBLE_DIFFICULTIES[rng.rand_weighted(DIFFICULTIES_WEIGHTS)]
	var lenghty = [0,1].pick_random()
	
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
			new_resource.reward = 50
		1:
			if lenghty:
				new_resource.ideal_max_lesson = 5
				new_resource.absolute_max_lesson = 7
				goals_weights = [1,3,7,10,7,3,1]
			else:
				new_resource.ideal_max_lesson = 4
				new_resource.absolute_max_lesson = 6
				goals_weights = [2,4,8,9,5,2,0]
			new_resource.reward = 100
		2:
			if lenghty:
				new_resource.ideal_max_lesson = 4
				new_resource.absolute_max_lesson = 6
				goals_weights = [0,1,4,9,12,7,4]
			else:
				new_resource.ideal_max_lesson = 3
				new_resource.absolute_max_lesson = 4
				goals_weights = [0,2,5,9,11,6,2]
			new_resource.reward = 150
		3:
			if lenghty:
				new_resource.ideal_max_lesson = 3
				new_resource.absolute_max_lesson = 4
				goals_weights = [0,0,0,3,8,6,3]
			else:
				new_resource.ideal_max_lesson = 2
				new_resource.absolute_max_lesson = 3
				goals_weights = [0,0,2,4,7,6,2]
			new_resource.reward = 250 
	
	new_resource.goal = POSSIBLE_GOALS[rng.rand_weighted(goals_weights)]
	if randi_range(0,1000000) == 8:
		new_resource.goal = 2 #Enjoy the free win, you earned it
	new_resource.difficulty = difficulty
	current_mission_resource = new_resource
	
