function spawn_enemies()
    enemy_timer += 1
    if enemy_timer % 60 == 0 then
        spawn_enemy()
    end
end

function spawn_enemy()
    local enemy_y = rnd(120)
    local enemy_x = 128
    add(
        enemies, {
            x = enemy_x,
            y = enemy_y,
            start_y = enemy_y,
            offset = rnd(1000),
            shoot_timer = 0,
            ballon = {
                x = enemy_x - 7,
                y = enemy_y - 18
            },
            weapon = {
                x = enemy_x - 2,
                y = enemy_y + 1,
                shot = false,
                speed = 3
            }
        }
    )
end

function move_enemies()
    for enemy in all(enemies) do
        -- Calculate the new x and y positions of the enemy
        local new_x = enemy.x - 0.2
        local new_y = enemy.start_y + sin(enemy.offset) * 3
        -- Update the position of the balloon and weapon
        enemy.ballon.x = new_x - 8
        enemy.ballon.y = new_y - 18
        if not enemy.weapon.shot then
            enemy.weapon.x = new_x - 2
            enemy.weapon.y = new_y + 1
        end
        -- Update the position of the enemy
        enemy.x = new_x
        enemy.y = new_y
        -- Update the offset for the sine wave motion
        enemy.offset += 0.02

        -- Increment shoot timer
        enemy.shoot_timer += 1
    end
end

function move_enemy_weapons()
    -- Move enemy weapons
    for enemy in all(enemies) do
        if enemy.weapon.shot then
            enemy.weapon.x -= enemy.weapon.speed
            if enemy.weapon.x < 0 then
                enemy.weapon.shot = false
                enemy.weapon.x = enemy.x - 2
                enemy.weapon.y = enemy.y + 1
            end
        end
    end
end

function draw_ballon(ballon)
    draw_large_sprite(ballon.x, ballon.y, 30, 2)

    -- Draw balloon string
    local string_start_y = ballon.y + 15
    local string_x = ballon.x + 9
    local string_end_y = string_start_y + 8
    local string_color = 6

    line(string_x, string_start_y, string_x, string_end_y, string_color)
end

function draw_weapon(weapon)
    spr(62, weapon.x, weapon.y)
end

function enemies_shoot()
    for enemy in all(enemies) do
        -- Check if it's time to shoot
        if enemy.shoot_timer >= 30 then
            -- shoot every 30 frames
            enemy.weapon.shot = true
            -- Reset shoot timer
            enemy.shoot_timer = 0
        end
    end
end