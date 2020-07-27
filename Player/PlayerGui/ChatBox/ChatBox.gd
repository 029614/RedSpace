extends Control


onready var chat_log = $VBoxContainer/RichTextLabel
onready var input_label = $VBoxContainer/HBoxContainer/Label
onready var input_field = $VBoxContainer/HBoxContainer/LineEdit



var groups = [
    {'name':'Global', 'color':'#ffffff'},
    {'name':'System', 'color':'#edbd00'},
    {'name':'Party', 'color':'#30f74f'},
    {'name':'Whisper', 'color':'#00ede8'},
   ]

var group_index = 0
var player_name = 'Test'
var input_focus = false



func _ready():
    $VBoxContainer/HBoxContainer/Label.text = '[' + Game.player_name + ']'


func _input(event):
    pass
    #if event is InputEventKey:
        #if event.is_action_released("T") and input_field != get_focus_owner():
            #input_field.grab_focus()


func _on_LineEdit_text_entered(new_text):
    var message_info = {
        'message':new_text,
        'color':groups[group_index]['color'],
        'username':Game.player_name,
        'group':groups[group_index]['name']
       }
    add_message(message_info)
    rpc("add_message", message_info)
    input_field.text = ''
    input_field.release_focus()


remote func add_message(message_info):
    #chat_log.add_text('[color= ' + message_info['color'] + ']')
    chat_log.add_text(message_info['group'] + '/' + message_info['username'] + ': ')
    chat_log.add_text(message_info['message'])
    chat_log.add_text('\n')

func _on_OptionButton_item_selected(id):
    group_index = id







