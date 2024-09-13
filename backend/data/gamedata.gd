extends Node

var player : CharacterBody2D

func setPlayer(node : CharacterBody2D):
	player = node
	
func isPlayer(node):
	return (node == player)
