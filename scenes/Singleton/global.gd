extends Node

@onready var IS_DEBUG = "debug" in OS.get_cmdline_args()

var DEBUG_SKIP_MISSION_SELECTION = false

var skill_list :Array[Control]= []

var boy_student_sprites = [
	preload("res://assets/students/guy1.png"),
	]
var girl_student_sprites = [
	preload("res://assets/students/girl1.png"),
]


var demon_heads : Array[Texture] = [
	preload("uid://dme4ic7obj7pq"),
	preload("uid://bmah484yl4akl"),
	preload("uid://5ifmk8x86m3s"),
	preload("uid://bp5bwct6wy6tb"),
	preload("uid://cf86hk0ybvc0e"),
	]

func _ready() -> void:
	if IS_DEBUG:
		print("DEBUG MODE ON")

func get_color_for_note(note):
	if note >= 10:
		return '#76ae7d'
	elif note <10:
		return "red"

func interleave_arrays(a: Array, b: Array) -> Array:
	var result: Array = []
	var size = min(a.size(), b.size())
	
	for i in size:
		result.append(a[i])
		result.append(b[i])
	
	return result
