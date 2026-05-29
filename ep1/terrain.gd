extends VoxelTerrain

const AIR: int = 0
const SOLID_BLOCK: int = 1

var vx: VoxelTool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vx = get_voxel_tool()


func _on_player_break_pressed(camera_pos: Vector3, camera_look_dir: Vector3) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_look_dir, 1000)
	if rc:
		vx.set_voxel(rc.position, AIR)


func _on_player_place_pressed(camera_pos: Vector3, camera_look_dir: Vector3) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_look_dir, 1000)
	if rc:
		vx.set_voxel(rc.previous_position, SOLID_BLOCK)
