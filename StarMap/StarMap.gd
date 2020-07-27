extends Control


onready var system_icons = $TextureRect/SystemIcons


# Called when the node enters the scene tree for the first time.
func _ready():
    Signals.connect("system_targeted", self, "targetSystem")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func createMap():
    var stars = Game.getStarMap()
    system_icons.global_position = $TextureRect.rect_size/2
    for star in stars.values():
        var system = load("res://StarMap/MapSystem.tscn")
        var news = system.instance()
        news.system_name = star['name']
        news.changeName(star['name'])
        news.system_govt = star['government']
        news.system_desc = star['description']
        news.system_connections = star['connections']
        news.system_id = star['id']
        news.system_position = star['position']
        system_icons.add_child(news)
        news.rect_position = star['position']


func targetSystem(id):
    for system in $TextureRect/SystemIcons.get_children():
        if system.system_id == id:
            system.target(true)
        else:
            system.target(false)


func _on_buttonCancel_pressed():
    hide()


func _on_buttonSelect_pressed():
    hide()
