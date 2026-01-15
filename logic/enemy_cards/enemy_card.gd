class_name EnemyCard
extends RefCounted

var rules: String
var name: String

func _init(_name: String, _rules: String):
	rules = _rules
	name = _name
	
func play(battle_controller, slot_index: int) -> void:
	push_error("EnemyCard.play() was not overridden!")
