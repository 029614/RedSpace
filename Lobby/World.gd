extends Node2D


var current_system = 0


# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func create_scene(system_id):
    if get_child_count() > 0:
        for child in get_children():
            child.queue_free()
            
    var s = load("res://Lobby/Scene.tscn")
    var news = s.instance()
    add_child(news)
    news.build_sys(system_id)
    
