extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    get_tree().get_root().connect("size_changed", self, "resize")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func resize():
    var width = get_viewport().size.x
    var height = get_viewport().size.y
    offset = Vector2(width/2, height/2)
    scale = Vector2(width/1920,height/1080)
