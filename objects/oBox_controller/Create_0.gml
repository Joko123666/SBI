
// 각 블록별 스프라이트 그룹 정의 (맵 사용)
block_sprites = ds_map_create();
block_sprites[? "I"] = sBlock_I;
block_sprites[? "O"] = sBlock_O;
block_sprites[? "T"] = sBlock_T;
block_sprites[? "S"] = sBlock_S;
block_sprites[? "Z"] = sBlock_Z;
block_sprites[? "L"] = sBlock_L;
block_sprites[? "J"] = sBlock_J;
block_sprites[? "dot"] = sBlock_dot;


// 각 블록 모양 정의
blocks_Aset = [
    {shape: [[1, 1, 1, 1]], type: "I"},
    {shape: [[1, 1], [1, 1]], type: "O"},
    {shape: [[1, 1, 1], [0, 1, 0]], type: "T"},
    {shape: [[1, 1, 0], [0, 1, 1]], type: "S"},
    {shape: [[0, 1, 1], [1, 1, 0]], type: "Z"},
    {shape: [[1, 1, 1], [1, 0, 0]], type: "L"},
    {shape: [[1, 1, 1], [0, 0, 1]], type: "J"}
];

// 각 블록 모양 정의
blocks_Bset = [
    {shape: [[1, 1, 1, 0]], type: "I"},
    {shape: [[1, 1], [1, 1]], type: "O"},
    {shape: [[1, 1, 1], [0, 1, 0]], type: "T"},
    {shape: [[1, 1, 0], [0, 1, 1]], type: "S"},
    {shape: [[0, 1, 1], [1, 1, 0]], type: "Z"},
    {shape: [[1, 1, 0], [1, 0, 0]], type: "L"},
    {shape: [[0, 1, 1], [0, 0, 1]], type: "J"}
];

// 각 블록 모양 정의
blocks_Cset = [
    {shape: [[1, 1, 0, 0]], type: "I"},
    {shape: [[1, 1], [1, 1]], type: "O"},
    {shape: [[1, 1, 1], [0, 1, 0]], type: "T"},
    {shape: [[1, 1, 0], [0, 1, 1]], type: "S"},
    {shape: [[0, 1, 1], [1, 1, 0]], type: "Z"},
    {shape: [[1, 1, 1], [1, 0, 0]], type: "L"},
    {shape: [[1, 1, 1], [0, 0, 1]], type: "J"},
	{shape: [[1]], type: "dot"}
];

box_width = 5;
box_height = 5;
box_size = 5;
box = array_create(box_width, array_create(box_width, [-1, -1])); // 6x6의 빈 박스 (-1로 초기화)
blocks_in_box = [];


fill_box(box_width, blocks_Aset);

