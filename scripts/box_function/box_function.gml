
// 박스를 비우는 함수
function clear_box() {
    for (var _i = 0; _i < box_size; _i++) {
        for (var _j = 0; _j < box_size; _j++) {
            box[_i, _j] = -1;  // 각 셀을 빈 상태로 초기화
        }
    }
    blocks_in_box = []; // 블록 정보 리스트 초기화
}

// 박스를 새로 채우는 함수
function refill_box(_box_size, _blocks) {
    clear_box();  // 박스를 초기화
    fill_box(_box_size, _blocks);   // 새로운 블록들로 박스 채우기
}

// 박스를 블록으로 채우는 함수
function fill_box(_box_size, _blocks) {
    var _attempts = 0; // 무한 반복 방지를 위한 시도 횟수 제한
    while (_attempts < 100) {
        _attempts++;
        
        // 무작위 블록과 회전을 선택
        var _block_index = irandom(array_length(_blocks) - 1); 
        var _block_data = _blocks[_block_index];
        var _block_shape = _block_data.shape;
        var _block_type = _block_data.type;
        
        var _rotation = irandom(3);   // 0~3 중 랜덤한 회전 (90도씩 회전)
        var _rotated_block = rotate_block(_block_shape, _rotation);
        
        // 무작위 좌표 선택
        var _x = irandom(_box_size - array_length_1d(_rotated_block));
        var _y = irandom(_box_size - array_length_2d(_rotated_block, 0));

        if (can_place_block(_rotated_block, _x, _y)) {
            var _sprite = block_sprites[? _block_type]; // 블록 타입에 따른 스프라이트 선택
            var _index = irandom(2);                   // 각 스프라이트의 3개 이미지 중 하나 선택
            
            // 블록 배치
            place_block(_rotated_block, _x, _y, _block_type);
            blocks_in_box[array_length(blocks_in_box)] = {
                sprite: _sprite, 
                image_index: _index, 
                x: _x, 
                y: _y, 
                rotation: _rotation, 
                type: _block_type
            };
        }
        
        // 박스가 완전히 채워졌다면 반복 중단
        if (is_box_filled()) {
            break;
        }
    }
}

// 2D 배열을 90도 단위로 회전하는 함수
function rotate_block(_block, _rotation) {
    var _rotated_block = _block;
    repeat (_rotation) {
        _rotated_block = transpose_and_reverse(_rotated_block);
    }
    return _rotated_block;
}

// 2D 배열을 전치하고 행을 뒤집어 90도 회전시키는 함수
function transpose_and_reverse(_array_2d) {
    var _rows = array_length_1d(_array_2d);
    var _cols = array_length_2d(_array_2d, 0);
    var _transposed = array_create(_cols, array_create(_rows, 0));
    
    for (var _i = 0; _i < _rows; _i++) {
        for (var _j = 0; _j < _cols; _j++) {
            _transposed[_j][_rows - _i - 1] = _array_2d[_i][_j];
        }
    }
    return _transposed;
}

// 블록을 특정 위치에 배치할 수 있는지 확인하는 함수
function can_place_block(_block, _x, _y) {
    for (var _i = 0; _i < array_length_1d(_block); _i++) {
        for (var _j = 0; _j < array_length_2d(_block, 0); _j++) {
            if (_block[_i, _j] == 1 && box[_x + _i, _y + _j] != -1) {
                return false;
            }
        }
    }
    return true;
}

// 블록을 박스에 배치하는 함수 (블록 타입 정보 추가)
function place_block(_block, _x, _y, _type) {
    for (var _i = 0; _i < array_length_1d(_block); _i++) {
        for (var _j = 0; _j < array_length_2d(_block, 0); _j++) {
            if (_block[_i, _j] == 1) {
                box[_x + _i, _y + _j] = _type; // 박스에 블록 타입 저장
            }
        }
    }
}

// 박스가 다 찼는지 확인하는 함수
function is_box_filled() {
    for (var _i = 0; _i < box_size; _i++) {
        for (var _j = 0; _j < box_size; _j++) {
            if (box[_i, _j] == -1) {
                return false;
            }
        }
    }
    return true;
}

// draw 이벤트에서 박스를 화면에 그리기
function draw_box(_x, _y) {
    var _cell_size = 32;  // 각 셀의 크기 (픽셀 단위)
	draw_rectangle(_x, _y, _x + _cell_size*box_size, _y + _cell_size*box_size, 0);
    for (var _i = 0; _i < array_length(blocks_in_box); _i++) {
        var _block = blocks_in_box[_i];
        draw_sprite_ext(_block.sprite, _block.image_index, _x + _block.y * _cell_size, _y + _block.x * _cell_size, 1, 1, _block.rotation * 90, c_white, 1);
    }
}

// 박스 상태를 화면에 문자로 출력하는 함수
function draw_text_box() {
    var _cell_size = 32; // 각 셀의 크기 (픽셀 단위)
    for (var _i = 0; _i < box_size; _i++) {
        for (var _j = 0; _j < box_size; _j++) {
            var _text = (box[_i, _j] == -1) ? "." : "X"; // 빈 공간은 ".", 블록이 있는 공간은 "X"
            draw_text(_j * _cell_size, _i * _cell_size, _text);
        }
    }
}

// 박스 상태를 화면에 블록의 타입을 텍스트로 출력하는 함수
function draw_block_types() {
    var _cell_size = 32; // 각 셀의 크기 (픽셀 단위)
    
    for (var _i = 0; _i < box_size; _i++) {
        for (var _j = 0; _j < box_size; _j++) {
            var _type = box[_i, _j];
            var _text = (_type == -1) ? "." : _type; // 빈 공간은 ".", 블록이 있는 공간은 타입으로 표시
            draw_text(_j * _cell_size, _i * _cell_size, _text);
        }
    }
}



