extends Node

var students_resources := []
var students := []
var name_info_labels : Array[RichTextLabel] = []
var note_info_labels : Array[RichTextLabel] = []
var student_scene = preload("res://scenes/students/student.tscn")
var gender = ["boy","girl"]
var boy_names = [
	"Kévin", "Maxime", "Mathéo", "Hugo", "Victor", "Julien",
	"Théo", "Sébastien", "Thomas", "Nicolas", "Hervé", "Alexis",
	"Rémi", "David", "Stephen", "Benjamin", "Frédéric",
	"Jérôme", "Johnnatan", "Antoine", "Anthony", "Jean-Marc",
	"Chen", "Cédric", "Dylan", "Abdel", "Abdallah",
	"Abel", "Christophe", "Yoann", "Steve"]
var girl_names = [
	"Lola", "Léa", "Margaret", "Ebène", "Julie", "Marie", "Claire",
	"Mélanie", "Céline", "Annabelle", "Fanny", "Morganne",
	"Adeline", "Rachida", "Roxanne", "Richarde", "Audrey",
	"Nadège", "Caroline", "Colette"]

const POSSIBLE_NOTES : Array[int] = [2,3,4,5,6,7,8,9,10,11,12,13]
var notes_weights : Array[int] = [5,5,12,12,20,30,20,8,2,2,1]
var rng = RandomNumberGenerator.new()

func generate_x_random_student(x) -> void:
	clear_students()
	clear_students_resources()
	name_info_labels.clear()
	note_info_labels.clear()
	
	for i in range(x):
		if i >= len(%DeskManager.desks):
			return
		var new_student_resource = StudentResource.new()
		var CaractereType = new_student_resource.CaractereType.duplicate()
		var random_key = CaractereType.keys().pick_random()
		new_student_resource.caractere = CaractereType[random_key]
		match new_student_resource.caractere: #TODO: should change depending on difficulty
			CaractereType.Reveur: 
				new_student_resource.ennui_de_base = randi_range(2,6)
				new_student_resource.stupidite_de_base = randi_range(3,4)
			CaractereType.Jovial: 
				new_student_resource.ennui_de_base = randi_range(2,3)
				new_student_resource.stupidite_de_base = randi_range(2,4)
			CaractereType.Malin: 
				new_student_resource.ennui_de_base = randi_range(0,3)
				new_student_resource.stupidite_de_base = randi_range(2,4)
			CaractereType.Timide: 
				new_student_resource.ennui_de_base = randi_range(1,4)
				new_student_resource.stupidite_de_base = randi_range(2,4)
			CaractereType.Clown:
				new_student_resource.ennui_de_base = randi_range(1,4)
				new_student_resource.stupidite_de_base = randi_range(2,4)
			CaractereType.Bruyant:
				new_student_resource.ennui_de_base = randi_range(1,4)
				new_student_resource.stupidite_de_base = randi_range(3,4)
			CaractereType.Manipulateur:
				new_student_resource.ennui_de_base = randi_range(0,3)
				new_student_resource.stupidite_de_base = randi_range(2,4)
			CaractereType.Hyperactif:
				new_student_resource.ennui_de_base = randi_range(1,4)
				new_student_resource.stupidite_de_base = randi_range(3,4)

		var student_gender = gender.pick_random()
		if student_gender == "boy":
			new_student_resource.sprite = Global.boy_student_sprites.pick_random()
			new_student_resource.student_name = boy_names.pick_random()
		elif student_gender == "girl":
			new_student_resource.sprite = Global.girl_student_sprites.pick_random()
			new_student_resource.student_name = girl_names.pick_random()
		else:
			print("WTF IS GOING ON, A STUDENT IS NON BINARY APPARENTLY (SUPPORT TO THEM BUT THAT'S NOT SUPPOSED TO HAPPEN IN THIS GAME THO)")
		students_resources.append(new_student_resource)
		new_student_resource.note = POSSIBLE_NOTES[rng.rand_weighted(notes_weights)]
		if randf() < .3:
			new_student_resource.note += 0.5
		
		var name_label = RichTextLabel.new()
		var note_label = RichTextLabel.new()
		set_label_settings(name_label)
		set_label_settings(note_label)
		name_label.text = "[color=326e7d]%s: "%[new_student_resource.student_name]
		note_label.text = '[right][color=#76ae7d]%s/20'%[new_student_resource.note]
		%StudentInfoContainer.add_child(name_label)
		%StudentInfoContainer.add_child(note_label)
		name_info_labels.append(name_label)
		note_info_labels.append(note_label)

func update_info_labels():
	for i in range(len(name_info_labels)):
		name_info_labels[i].text = "[color=326e7d]%s: "%[students_resources[i].student_name]
	for i in range(len(note_info_labels)):
		note_info_labels[i].text = '[right][color=#76ae7d]%s/20'%[students_resources[i].note]


func set_label_settings(label_to_change):
	label_to_change.bbcode_enabled = true
	label_to_change.add_theme_font_size_override("normal_font_size",16)
	label_to_change.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label_to_change.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label_to_change.scroll_active = false
	label_to_change.custom_minimum_size = Vector2(16,32)

func assign_students_to_random_desk():
	var possible_spot := []
	for desk in %DeskManager.desks:
		if !desk.student:
			possible_spot.append(desk)
	for student_resource in students_resources:
		var new_spot = possible_spot.pick_random()
		possible_spot.erase(new_spot)
		var new_student = student_scene.instantiate()
		new_student.resource = student_resource
		new_spot.add_child(new_student)
		new_spot.student = new_student
		students.append(new_student)


func clear_students():
	for student in students:
		student.queue_free()

func clear_students_resources():
	students_resources.clear()

func immune_all_students():
	for student in students:
		student.untouchable = true

func reset_all_students():
	for student in students:
		student.reset()

func _ready() -> void:
	ManagerList.student_manager = self
	await get_tree().process_frame
	generate_x_random_student(7)
	assign_students_to_random_desk()

func _process(_delta: float) -> void:
	update_info_labels()
