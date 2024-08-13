# Give the component a class name so it can be instanced as a custom node
class_name FlashComponent
extends Node

# The flash component uses a flash material. I chose to preload this into a constant
# But you could also export a material instead to allow the component to use a variety
# of different materials
const FLASH_MATERIAL = preload("res://effects/white_flash_material.tres")

# Export the sprite this compononet will be flashing
@export var sprite: Node2D

# Export a duration for the flash
@export var flash_duration: = 0.2

# We need to store the original sprite's material so we can reset it after the flash
var original_sprite_material_array: Array[Material]
var original_sprite_material: Material

# Create a timer for the flash component to use
var timer: Timer = Timer.new()

func _ready() -> void:
	# We have to add the timer as a child of this component in order to use it
	add_child(timer)

	# Store the original sprite material
	if (sprite.get_child_count() > 0):
		for sprite1 in sprite.get_children():
			original_sprite_material_array.append(sprite1.material);
	else:
		original_sprite_material = sprite.material
	
	
# This is the function we can use to activate this component
func flash():
	if (sprite.get_child_count() > 0):
		# Start the timer (passing in the flash duration)
		timer.start(flash_duration)
		for sprite1 in sprite.get_children():
			# Set the sprite's material to the flash material
			sprite1.material = FLASH_MATERIAL
	
		# Wait until the timer times out
		await timer.timeout
	
		for sprite1 in sprite.get_children():
			# Set the sprite's material back to the original material that we stored
			sprite1.material = original_sprite_material
	else:
		# Set the sprite's material to the flash material
		sprite.material = FLASH_MATERIAL
	
		# Start the timer (passing in the flash duration)
		timer.start(flash_duration)
	
		# Wait until the timer times out
		await timer.timeout
	
		# Set the sprite's material back to the original material that we stored
		sprite.material = original_sprite_material
