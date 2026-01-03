extends Card
class_name HydraulicUppercutCard

func _init():
	name = "Hydraulic Uppercut"
	rules = "If played from leftmost\nslot: Deal 20 dmg.\nOtherwise: Deal 10 dmg."
	cost = 1
	
func play(battle: Battle, slot_index: int) -> void:
	var dmg
	if slot_index == 0:
		battle.output_label.text = "Dealt 20 damage."
		dmg = 20
	else:
		battle.output_label.text = "Dealt 10 damage."
		dmg = 10
		
	battle.enemy_bot.take_damage(dmg)
