class_name Player
extends CharacterBody2D

@export var move_speed := 100.0
@export var climb_speed := 150.0
@export var jump_force := 300.0
@export var gravity := 150.0
@export var score := 0
@export var label : Label

var is_climbing := false


func _physics_process(delta: float) -> void:
	if not is_on_floor() and not is_climbing:
		velocity.y += gravity * delta
	
	
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
	
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
	
	if Input.is_action_just_pressed("up") and is_climbing:
		velocity.y -= climb_speed
	
	if Input.is_action_pressed("down") and is_climbing:
		velocity.y += climb_speed
	
	if Input.is_action_pressed("jump") and is_on_floor() and not is_climbing:
		velocity.y = -jump_force

	move_and_slide()
	if global_position.y > 100:
		game_over()

func game_over():
	get_tree().reload_current_scene()

func update_label():
	label.text = "Score: %s" % score

func add_score(amount: int):
	score += amount
	update_label()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.get_groups())
	if body.is_in_group("climeable"):
		is_climbing = true
	if body.is_in_group("drownable"):
		game_over()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("climeable"):
		is_climbing = false
