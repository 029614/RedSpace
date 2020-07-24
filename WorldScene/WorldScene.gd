extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.connect("player_joined_scene", self, "add_player")
    var thisPlayer = preload("res://Ships/Testing/ShipObject.tscn").instance()
    thisPlayer.set_name(Global.players[str(get_tree().get_network_unique_id())]['name'])
    thisPlayer.set_network_master(get_tree().get_network_unique_id())
    $Actors/Human.add_child(thisPlayer)
    
    for player in Global.players:
        if Global.players[player]['id'] != get_tree().get_network_unique_id():
            add_player(Global.players[player]['id'])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
func load_player(id):
    pass

func add_player(id):
    print("Adding player: ", id)
    var new_player = preload("res://Ships/Testing/ShipObject.tscn").instance()
    new_player.set_name(Global.players[id]['name'])
    new_player.set_network_master(id)
    $Actors/Human.add_child(new_player)
