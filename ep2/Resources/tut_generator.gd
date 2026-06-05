extends VoxelGeneratorScript
class_name TutorialGenerator

@export var noise: FastNoiseLite
@export var base_height: int = 0
@export var max_height: int = 64

@export var spikiness: float = 1

@export var layers: Array[TerrainLayer]
@export var lowest_layer: Blocks.ID = Blocks.ID.COBBLESTONE

func _generate_block(out_buffer: VoxelBuffer, origin_in_voxels: Vector3i, lod: int) -> void:
	var buf_size: Vector3i = out_buffer.get_size()
	
	if origin_in_voxels.y < base_height-buf_size.y:
		out_buffer.fill(lowest_layer)
		return
	
	for z: int in buf_size.z:
		for x: int in buf_size.x:
			var pos: Vector2i = Vector2i(origin_in_voxels.x + x, origin_in_voxels.z + z)
			var norm_noise: float = (noise.get_noise_2d(pos.x, pos.y)+1) / 2
			var surf_y: int = max_height*pow(norm_noise, spikiness) - origin_in_voxels.y
			
			var current_height: int = surf_y
			for layer: TerrainLayer in layers:
				out_buffer.fill_area(
					layer.id,
					Vector3i(x, current_height-layer.height, z),
					Vector3i(x+1, current_height, z+1)
				)
				current_height -= layer.height
			
			out_buffer.fill_area(
				lowest_layer,
				Vector3i(x, 0, z),
				Vector3i(x+1, current_height, z+1)
			)
