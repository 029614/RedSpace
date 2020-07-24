extends Node2D
class_name Star_System


# ------ System Constants ------ #
var sys_name:String
var sys_id:int
var sys_coord:Vector2
var sys_connections = []
var sys_desc:String


# ------ Game State Variables -----#
var sys_modifiers = []
var sys_state:String
var sys_govt:String


# ------ Logs ------ #
# --- 0 is the most recent --- #
var past_govts = []
var past_modifiers = []


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
