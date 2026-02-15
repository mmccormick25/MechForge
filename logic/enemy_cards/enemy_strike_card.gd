extends EnemyCard
class_name EnemyStrikeCard

func _init():
	name = "Strike"
	rules = "Deal 10 damage."
	
func play(battle: Battle) -> void:
	battle.player_bot.take_damage(10)
	battle.output_label.text = "Took " + str(10) + " damage."
	print("Took 10 damage.")
