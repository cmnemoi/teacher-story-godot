extends Resource
class_name StudentResource
enum CaractereType {Reveur,Jovial,Malin,Timide,Clown,Bruyant,Manipulateur,Hyperactif}


@export var caractere : CaractereType
@export var stupidite_de_base := 3
@export var ennui_de_base := 2
@export var student_name := "Michel"
@export var note: float = 10
@export var sprite: Texture2D = preload("res://assets/students/guy1.png")
@export var bag_sprite : Texture2D = Global.BAG_SPRITES[0]
@export var standing_sprite :Texture2D = preload("uid://t3hq4lvdwpn6")
