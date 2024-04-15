class_name VisualNovelPhrase
extends Resource

enum Character {
	Olive,
	Lusca,
	Gratin,
}

@export var character: Character
@export_multiline var rich_text: String = ""
