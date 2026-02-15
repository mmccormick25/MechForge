# Deck.gd
extends RefCounted
class_name EnemyDeck

var deck_cards: Array = []

signal top_card_changed(enemy_card : EnemyCard)

func _init():
	deck_cards = []

	# Add test enemy cards
	for i in range(10):
		#deck_cards.append(Card.new("TestCard", "DA RULES", 1))
		deck_cards.append(EnemyStrikeCard.new())
		
	

# Remove and return top card of deck
func remove_top_card() -> EnemyCard:
	if deck_cards.is_empty():
		return null

	return deck_cards.pop_back()

# Peek top card of deck
func get_top_card() -> EnemyCard:
	if deck_cards.is_empty():
		return null
	return deck_cards[-1]

# Play top card of enemy deck
func play_top_card(battle : Battle):
	var card_to_play = remove_top_card()
	
	# If enemy deck had card on top
	if card_to_play:
		# Play enemy card
		card_to_play.play(battle)
		
		# Get next card in deck
		var next_card = get_top_card()
		emit_signal("top_card_changed", next_card)

func add_top_card(card: Card) -> void:
	if card != null:
		deck_cards.append(card)
