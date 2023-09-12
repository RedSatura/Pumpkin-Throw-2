extends VBoxContainer

export var title_text = ""
export var description_text = ""

onready var title = $Title
onready var description = $Description
onready var item_display = $ItemDisplay

func _ready():
	ShopEventBus.connect("update_item_display", self, "update_display")

func update_display(path):
	if path != null:
		var img = Image.new()
		img.load(path)
		var tex = ImageTexture.new()
		tex.create_from_image(img)
		item_display.texture = tex
