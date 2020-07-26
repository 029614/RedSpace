extends Control


onready var map_center = Game.player_ref.global_position
var map_info
onready var map_correction = $Panel.rect_size/2


func _ready():
    $Panel/Sprite.position = map_correction


func _physics_process(delta):
    $Panel/Bodies.position = (Game.player_ref.global_position/10*-1) + map_correction
    $Panel/Sprite.rotation = Game.player_ref.ship.rotation


func create_map():
    for p in Game.starmap.values():
        if p['id'] == Game.current_system:
            map_info = p['planets']
    for p in map_info.values():
        var s = Sprite.new()
        var it = ImageTexture.new()
        it.load("res://Icons/MapPlanetIcon.png")
        s.set_texture(it)
        s.set_scale(Vector2(.05,.05))
        s.global_position = p['pos']/10
        $Panel/Bodies.add_child(s)
