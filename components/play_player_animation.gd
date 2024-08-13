class_name PlayPlayerAnimation
extends Node

@export var animationPlayer: AnimationPlayer

func play(animationName: String):
	animationPlayer.play(animationName)
