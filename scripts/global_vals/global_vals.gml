
function init_global_vals()
{
	// 각 블록별 스프라이트 그룹 정의
	global.block_sprites = 
	{
	    "I": sBlock_I,
	    "O": sBlock_O,
	    "T": sBlock_T,
	    "S": sBlock_S,
	    "Z": sBlock_Z,
	    "L": sBlock_L,
	    "J": sBlock_J
	};

	// 각 블록 모양 정의
	global.blocks = 
	[
	    {shape: [[1, 1, 1, 1]], type: "I"},
	    {shape: [[1, 1], [1, 1]], type: "O"},
	    {shape: [[1, 1, 1], [0, 1, 0]], type: "T"},
	    {shape: [[1, 1, 0], [0, 1, 1]], type: "S"},
	    {shape: [[0, 1, 1], [1, 1, 0]], type: "Z"},
	    {shape: [[1, 1, 1], [1, 0, 0]], type: "L"},
	    {shape: [[1, 1, 1], [0, 0, 1]], type: "J"}
	];
}