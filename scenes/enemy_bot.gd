extends Node2D

@onready var bot_texture = $EnemyBotTexture
@onready var health_label = $HealthNumberLabel

var bot_name : String
var bot_health : int = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage(dmg: int) -> void:
	bot_health -= dmg
	health_label.text = str(bot_health)
