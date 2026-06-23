extends Resource
class_name CaractereResource
enum CaractereType {GrosDormeur,Insolent,CassePied,Intello,Musqué,Nul,OeuilDeLynx,SansGene,Timide,TresBavard}


@export var name : String
@export var level : int #level minimum pour rencontrer ce caractère
@export var unique : int # 0 : caractère tiré pour tout le monde. 1 : peut être seul ou accompagné. 2 : caractère unique sur l'élève (hors ceux à 0)
@export var rare : int #rareté du caractère, de 0 à 4.
@export var hostility : int
@export var modKnow : int
@export var desc : String
@export var possible_chouchou_skills : Array[SkillResource]
