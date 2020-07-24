extends Node2D

var mode:String

func _ready():
    get_tree().connect("network_peer_connected", self, "_player_connected")

func _player_connected(id):
    print("Player connected to server! ID: ", id)
    Global.player_info = {'name':'new player', 'id':str(id)}
    rpc_id(id,"register_player",Global.player_info)


remotesync func register_player(info):
    var id = get_tree().get_rpc_sender_id()
    Global.players[id] = info
    print('Player list: ',Global.players)


func _on_buttonHost_pressed():
    $PopupPanel.popup_centered()
    $PopupPanel/VBoxContainer/HBoxContainer.hide()
    mode = 'host'


func host():
    print("Hosting network")
    var host = NetworkedMultiplayerENet.new()
    var res = host.create_server(Global.host_server_port,Global.host_max_connections)
    if res != OK:
        print("Error creating server")
        return
    
    print("Listening on port: ", Global.host_server_port)
    $VBoxContainer/buttonJoin.hide()
    $PopupPanel.hide()
    $VBoxContainer/buttonHost.disabled = true
    get_tree().set_network_peer(host)
    var id = get_tree().get_network_unique_id()
    Global.player_info = {'name':'host', 'id':str(id)}
    rpc_id(id,"register_player",Global.player_info)
    print(Global.players)
    var game = preload("res://WorldScene/WorldScene.tscn").instance()
    get_tree().get_root().add_child(game)
    hide()


func _on_buttonJoin_pressed():
    $PopupPanel.popup_centered()
    mode = 'join'


func join():
    print("Joining network")
    var host = NetworkedMultiplayerENet.new()
    host.create_client(Global.host_server_address, Global.host_server_port)
    get_tree().set_network_peer(host)
    $VBoxContainer/buttonHost.hide()
    $PopupPanel.hide()
    $VBoxContainer/buttonJoin.disabled = true
    var game = preload("res://WorldScene/WorldScene.tscn").instance()
    get_tree().get_root().add_child(game)
    Signals.emit_signal('player_joined_scene', get_tree().get_network_unique_id())


func _on_IPEdit_text_changed(new_text):
    Global.host_server_address = new_text


func _on_PortEdit_text_changed(new_text):
    Global.host_server_port = int(new_text)


func _on_buttonConfirm_pressed():
    if mode == 'join':
        join()
    elif mode == 'host':
        host()
