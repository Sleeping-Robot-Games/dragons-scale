function spawn_enemies()
    enemy_timer += 1
    if enemy_timer % 60 == 0 then
        local y = rnd(128)
        add(
            enemies, {
                x = 128,
                y = y,
                start_y = y,
                offset = rnd(1000)
            }
        )
    end
end

function move_enemies()
    for enemy in all(enemies) do
        enemy.x -= 0.5
        enemy.y = enemy.start_y + sin(enemy.offset) * 3
        enemy.offset += 0.02
    end
end

function draw_ballon(x, y)
    local balloon_y = y - 18
    local balloon_x = x - 7
    draw_large_sprite(balloon_x, balloon_y, 30, 2)

    -- Draw balloon string
    local string_start_y = balloon_y + 15
    local string_x = x + 2
    local string_end_y = string_start_y + 8
    local string_color = 6

    line(string_x, string_start_y, string_x, string_end_y, string_color)
end

function draw_weapon(x, y)
    spr(62, x - 2, y + 1)
end