extends Card
class_name RewindCard

func _init():
	name = "Rewind"
	rules = "SHIFT -1"
	cost = 0
	
func play(battle: Battle, slot_index: int) -> void:
	battle.shift_conveyor(-1)
