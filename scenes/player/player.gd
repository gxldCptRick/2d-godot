class_name Player
extends CharacterBody2D

@export var move_speed := 100.0
@export var jump_force := 300.0
@export var gravity := 150.0
@export var score := 0
@export var label : Label

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
	
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= move_speed
	
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
