extends Resource
class_name Blocks

enum ID {
	AIR,
	COBBLESTONE,
	DIRT,
	GRASS,
	SIX_SIDES,
	ID_MAX
}

static func id_to_name(id: ID) -> String:
	match id:
		ID.AIR: return "air"
		ID.COBBLESTONE: return "cobblestone"
		ID.DIRT: return "dirt"
		ID.GRASS: return "grass"
		ID.SIX_SIDES: return "six_sides"
	
	return "invalid"
