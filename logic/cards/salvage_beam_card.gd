extends Card
class_name SalvageBeamCard

func _init():
	name = "Salvage Beam"
	rules = "Deal 5 + 3 X [Scrap] dmg."
	cost = 1
	
func play(battle: Battle, slot_index: int) -> void:
	var dmg = 5 + (3 * battle.scrap_pile.scrap_cards.size())
	battle.output_label.text = "Dealt " + str(dmg) + " damage."
	battle.enemy_bot.take_damage(dmg)
