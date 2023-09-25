extends VBoxContainer

export(String) var title_text = "" 
export(String, MULTILINE) var description_text = ""

onready var title = $Title
onready var description = $Description
onready var item_display = $ItemDisplay

func _ready():
	ShopEventBus.connect("update_item_display", self, "update_display")
	ShopEventBus.connect("update_item_display_title", self, "update_title")
	ShopEventBus.connect("update_item_display_description", self, "update_description")

func update_display(path):
	if path != null:
		var img = Image.new()
		img.load(path)
		var tex = ImageTexture.new()
		tex.create_from_image(img)
		item_display.texture = tex

func update_title(string):
	title.text = string
	
func update_description(string):
	description.text = string
