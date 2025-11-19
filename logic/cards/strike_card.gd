extends Card
class_name StrikeCard

func _init():
	name = "Strike"
	rules = "Deal 10 damage."
	cost = 1
	
func play(battle: Battle, slot_index: int) -> void:
	battle.output_label.text = "Dealt 10 damage."
	print("Dealt 10 damage.")
