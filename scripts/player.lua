function player_movement()
    if (btn(0)) player.x = max(0, player.x - player.speed)
    if (btn(1)) player.x = min(128 - 16, player.x + player.speed)
    if (btn(2)) player.y = max(0, player.y - player.speed)
    if (btn(3)) player.y = min(128 - 16, player.y + player.speed)
    -- Start dashing
    if btnp(4) and not player.is_dashing then
        player.is_dashing = true
        player.dash_timer = 0
    end

    -- Perform dash
    if player.is_dashing then
        player.x = min(128 - 16, player.x + 5)
        player.dash_timer += 1

        -- Check if dash duration has been exceeded
        if player.dash_timer >= player.dash_duration then
            player.is_dashing = false
        end
    end
end

function shoot_fireball()
    if btnp(5) then
        add(fireballs, { x = player.x + 14, y = player.y + 8, speed = 3 })
    end
end

-- TODO: Hold 5 to breath fire

function draw_player()
    local frame = 1
    if (player.is_dashing) frame = 33
    draw_large_sprite(player.x, player.y, frame, 2)
end