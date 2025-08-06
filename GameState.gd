extends Node

enum TOOL{
	SHOVEL,
	SHEARS,
	SEED,
	POT,
	REMOVE,
	NONE
}

var CurrentTool = TOOL.NONE

var SaveManager

var Score = 0
