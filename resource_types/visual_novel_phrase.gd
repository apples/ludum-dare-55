class_name VisualNovelPhrase
extends Resource

enum Character {
	Bingus,
	Yolder,
	Numi,
}

@export var character: Character
@export_multiline var rich_text: String = ""
