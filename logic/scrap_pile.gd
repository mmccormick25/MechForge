extends RefCounted
class_name ScrapPile

var scrap_cards: Array = []


func _init():
	scrap_cards = []


func add_to_scrap(card: Card) -> void:
	if card != null:
		scrap_cards.append(card)

	print_scrap()


func remove_top_card() -> Card:
	if scrap_cards.is_empty():
		return null

	return scrap_cards.pop_back()


func print_scrap() -> void:
	print("== SCRAP CARDS ==")
	for c in scrap_cards:
		if c == null:
			print("Empty  ")
		else:
			print(c.name + "  ")

	print("==================")
