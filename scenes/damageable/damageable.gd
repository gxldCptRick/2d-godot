extends Area2D

@export var damageable: Damageable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(damageable.scene.instantiate())


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.game_over()
