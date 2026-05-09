extends Control
@onready var up_sprite: TextureRect = $Panel/up_sprite
@onready var name_label: RichTextLabel = %Name
@onready var hp_container: HBoxContainer = $Panel/HpContainer
@onready var note_label: RichTextLabel = %Note
@onready var caractere_label: RichTextLabel = %Caractere
const SPRITE_ENNUI = preload("uid://1qgo66qnt5ib")

var life_sprite = preload("uid://dtlcn2mtrw7ax")

func change(student_name,standing_sprite,life_amount,shield_amount,note,caractere):
	for node in hp_container.get_children():
		hp_container.remove_child(node)
		node.queue_free()
	name_label.text = student_name
	up_sprite.texture = standing_sprite
	for i in life_amount:
		var life = life_sprite.instantiate()
		life.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		hp_container.add_child(life)
	for i in shield_amount:
		var shield = life_sprite.instantiate()
		shield.ennui = true
		shield.texture = SPRITE_ENNUI
		shield.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		hp_container.add_child(shield)
	note_label.text = "%s/20"%int(note)
	caractere_label.text = caractere
