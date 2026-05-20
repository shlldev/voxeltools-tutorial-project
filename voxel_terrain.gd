extends VoxelTerrain

var vx: VoxelTool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vx = get_voxel_tool()

func _on_player_break_pressed(camera_pos: Vector3, camera_dir: Vector3) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_dir, 1000)
	if rc:
		vx.set_voxel(rc.position, 0)


func _on_player_place_pressed(camera_pos: Vector3, camera_dir: Vector3) -> void:
	var rc: VoxelRaycastResult = vx.raycast(camera_pos, camera_dir, 1000)
	if rc:
		vx.set_voxel(rc.previous_position, 1)
