class_name EnemyCard
extends RefCounted

var rules: String
var name: String
var enemy_card_display : EnemyCardDisplay

func _init(_name: String, _rules: String):
	rules = _rules
	name = _name
	
func play(battle_controller) -> void:
	push_error("EnemyCard.play() was not overridden!")
