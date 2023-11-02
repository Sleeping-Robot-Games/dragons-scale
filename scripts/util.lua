function draw_large_sprite(x, y, id, size)
    for i = 0, size - 1 do
        for j = 0, size - 1 do
            spr(id + j + i * 16, x + j * 8, y + i * 8)
        end
    end
end