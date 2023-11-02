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
            reload_timer = 0,
            balloon = {
                x = enemy_x - 7,
                y = enemy_y - 18,
                popped = false
            },
            weapon = {
                x = enemy_x - 2,
                y = enemy_y + 1,
                speed = 3,
                shot = false
            }
        }
    )
end

function move_enemies()
    for enemy in all(enemies) do
        -- enemy's balloon was popped and they fallin
        if enemy.balloon.popped then
            local new_y = enemy.y + 1
            enemy.y = new_y
            enemy.weapon.y += 1.5
            -- deletes enemy from table when off screen
            if (enemy.y > 128) del(enemies, enemy)
        else
            -- Calculate the new x and y positions of the enemy
            local new_x = enemy.x - 0.5
            local new_y = enemy.start_y + sin(enemy.offset) * 3
            -- Update the position of the balloon and weapon
            enemy.balloon.x = new_x - 8
            enemy.balloon.y = new_y - 18
            enemy.weapon.x = new_x - 2
            enemy.weapon.y = new_y + 1
            -- Update the position of the enemy
            enemy.x = new_x
            enemy.y = new_y
            -- Update the offset for the sine wave motion
            enemy.offset += 0.02

            -- Increment reload timer
            if enemy.weapon.shot then
                enemy.reload_timer += 1
            else
                -- Increment shoot timer
                enemy.shoot_timer += 1
            end
        end
    end
end

function move_enemy_weapons()
    -- Move enemy weapons
    for weapon in all(weapons) do
        weapon.x -= weapon.speed
        if weapon.x < 0 then
            del(weapons, weapon)
        end
    end
end

function draw_balloon(balloon)
    if (balloon.popped) return
    -- draw if balloon is popped
    draw_large_sprite(balloon.x, balloon.y, 30, 2)

    -- Draw balloon string
    local string_start_y = balloon.y + 15
    local string_x = balloon.x + 9
    local string_end_y = string_start_y + 8
    local string_color = 6

    line(string_x, string_start_y, string_x, string_end_y, string_color)
end

function draw_weapon(weapon)
    spr(62, weapon.x, weapon.y)
end

function enemies_shoot()
    for enemy in all(enemies) do
        -- shoot every 30 frames
        if enemy.shoot_timer >= 60 then
            -- Reset shoot timer
            enemy.shoot_timer = 0
            enemy.weapon.shot = true
            add(
                weapons, {
                    x = enemy.weapon.x,
                    y = enemy.weapon.y,
                    speed = enemy.weapon.speed
                }
            )
        end
    end
end

function enemies_reload()
    for enemy in all(enemies) do
        -- shoot every 30 frames
        if enemy.reload_timer >= 30 then
            -- Reset reload timer
            enemy.reload_timer = 0
            enemy.weapon.shot = false
        end
    end
end