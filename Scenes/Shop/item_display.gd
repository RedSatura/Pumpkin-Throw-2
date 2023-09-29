extends VBoxContainer

export(String) var title_text = "" 
export(String, MULTILINE) var description_text = ""

onready var title = $Title
onready var description = $ScrollContainer/Description
onready var item_display = $ItemDisplay

func _ready():
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_item_display", self, "update_display")
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_item_display_title", self, "update_title")
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_item_display_description", self, "update_description")

func update_display(path):
	var dir = Directory.new()
	dir.open("user://")
	if dir.file_exists(path):
		item_display.texture = load(path)
	else:
		item_display.texture = load(path)

func update_title(string):
	title.text = string
	
func update_description(string):
	description.text = string
