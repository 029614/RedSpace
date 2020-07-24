extends Node2D


var player_name:String
var player_money:int
var player_combat_rating:int
var player_govt_relationships = {} #Each government gets a value between -100 and 100

onready var player_camera = $Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
    pass
    
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
