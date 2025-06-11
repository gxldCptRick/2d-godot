extends Area2D

@export_file("*.tscn") var next_scene
@export var attached_group: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(attached_group):
		get_tree().change_scene_to_file(next_scene)
