class_name Card
extends RefCounted

var name: String
var rules: String
var cost: int

func _init(_name: String, _rules: String, _cost: int):
	name = _name
	rules = _rules
	cost = _cost
	
func play(battle_controller, slot_index: int) -> void:
	push_error("Card.play() was not overridden!")
