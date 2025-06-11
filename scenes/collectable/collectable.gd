class_name CollectableItem
extends Area2D

@export var collectable: Collectable
@export var collector_group: String
@export var bob_height := 5.0
@export var bob_speed := 5.0

var start_y : float
var time: float = 0.0

func _ready():
	start_y = global_position.y
	add_child(collectable.scene.instantiate())


func _process(delta: float) -> void:
	time += delta
	var sin_delta := (sin(time * bob_speed) + 1) / 2
	global_position.y = start_y + (sin_delta * bob_height)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(collector_group) and is_instance_of(body, Player):
		body.add_score(collectable.score)
		queue_free()
