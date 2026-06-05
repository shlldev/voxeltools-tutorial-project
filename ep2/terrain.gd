extends VoxelTerrain

const AIR: int = 0

var vx: VoxelTool

@onready var place_indicator: MeshInstance3D = $PlaceIndicator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vx = get_voxel_tool()


func _on_player_break_pressed(camera_pos: Vector3, camera_look_dir: Vector3) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_look_dir, 1000)
	if rc:
		vx.set_voxel(rc.position, AIR)


func _on_player_place_pressed(camera_pos: Vector3, camera_look_dir: Vector3, block_id: Blocks.ID) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_look_dir, 1000)
	if rc:
		vx.set_voxel(rc.previous_position, block_id)


func _on_player_hover_requested(camera_pos: Vector3, camera_look_dir: Vector3, block_id: Blocks.ID) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_look_dir, 1000)
	if rc:
		place_indicator.position = Vector3(rc.previous_position) + Vector3.ONE*0.5
		var library: VoxelBlockyLibrary = mesher.library
		var mat: StandardMaterial3D = place_indicator.mesh.surface_get_material(0)
		var model: VoxelBlockyModelCube = library.get_model(block_id)
		mat.albedo_texture = model.get_material_override(0).albedo_texture
