extends Panel
class_name MissionSelectionInstance

func update_ui(mission_resource):
	%MissionInfoContainer.update_objective_label("Note minimum [color=%s] [b]  %s/20 [/b] [/color]"%[Global.get_color_for_note(mission_resource.goal),mission_resource.goal])
	%MissionInfoContainer.update_reward_label("[color=f07c46][b]%s[/b][/color] [img]uid://dfcgw32nv5d56[/img][font_size=12] [i](reste %s cours) [/i] [/font_size]"%[mission_resource.reward,mission_resource.ideal_max_lesson])
	%HeadsContainer.texture = Global.demon_heads[mission_resource.difficulty+1]
