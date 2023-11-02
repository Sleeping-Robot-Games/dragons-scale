function player_movement()
    if btn(0) then player.x = max(0, player.x - player.speed) end
    if btn(1) then player.x = min(128 - 16, player.x + player.speed) end
    if btn(2) then player.y = max(0, player.y - player.speed) end
    if btn(3) then player.y = min(128 - 16, player.y + player.speed) end
end

function shoot_fireball()
    if btnp(5) then
        add(fireballs, { x = player.x + 14, y = player.y + 8, speed = 3 })
    end
end

-- TODO: Dash forward (to eat) btn(4)

-- TODO: Hold 5 to breath fire