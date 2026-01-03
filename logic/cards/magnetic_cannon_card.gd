extends Card
class_name MagneticCannonCard

func _init():
	name = "Magnetic Cannon"
	rules = "Deal 6 X [Slot] damage."
	cost = 1
	
func play(battle: Battle, slot_index: int) -> void:
	var dmg = slot_index * 6
	battle.output_label.text = "Dealt " + str(dmg) + " damage."
	battle.enemy_bot.take_damage(dmg)
