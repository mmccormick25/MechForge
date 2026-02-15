# Deck.gd
extends RefCounted
class_name EnemyDeck

var deck_cards: Array = []

func _init():
	deck_cards = []

	# Add dummy cards like in Java constructor
	for i in range(10):
		#deck_cards.append(Card.new("TestCard", "DA RULES", 1))
		deck_cards.append(EnemyStrikeCard.new())

func remove_top_card() -> Card:
	if deck_cards.is_empty():
		return null

	return deck_cards.pop_back()

func add_top_card(card: Card) -> void:
	if card != null:
		deck_cards.append(card)
