function spawn_knights()
    knight_timer += 1
    if knight_timer % 60 == 0 then
        spawn_knight()
    end
end

function spawn_knight()
    local knight_y = 8 + rnd(120 - 5)
    local knight_x = 128
    add(
        knights, {
            type = 'knight',
            x = knight_x,
            y = knight_y,
            hp = 4,
            start_y = knight_y,
            offset = rnd(1000),
            shoot_timer = 0,
            reload_timer = 0,
            balloon = {
                x = knight_x - 7,
                y = knight_y - 18,
                hp = 2,
                popped = false,
                fire_particles = {}
            },
            weapon = {
                x = knight_x - 2,
                y = knight_y + 1,
                speed = 3,
                shot = false
            }
        }
    )
end

function move_knights()
    for knight in all(knights) do
        -- knight's balloon was popped and they fallin
        if knight.balloon.popped then
            local new_y = knight.y + 1
            knight.y = new_y
            knight.weapon.y += 1.5
            -- deletes knight from table when off screen
            if (knight.y > 128) del(knights, knight)
        else
            -- Calculate the new x and y positions of the knight
            local new_x = knight.x - 0.5
            local new_y = knight.start_y + sin(knight.offset) * 3
            -- Update the position of the balloon and weapon
            knight.balloon.x = new_x - 8
            knight.balloon.y = new_y - 18
            knight.weapon.x = new_x - 2
            knight.weapon.y = new_y + 1
            -- Update the position of the knight
            knight.x = new_x
            knight.y = new_y
            -- Update the offset for the sine wave motion
            knight.offset += 0.02

            -- Increment reload timer
            if knight.weapon.shot then
                knight.reload_timer += 1
            else
                -- Increment shoot timer
                knight.shoot_timer += 1
            end
        end
    end
end

function move_knight_weapons()
    -- Move knight weapons
    for weapon in all(knight_weapons) do
        weapon.x -= weapon.speed
        if weapon.x < 0 then
            del(knight_weapons, weapon)
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

function draw_knight_weapon(weapon)
    spr(45, weapon.x, weapon.y)
end

function knights_shoot()
    for knight in all(knights) do
        -- shoot every 30 frames
        if knight.shoot_timer >= 60 then
            -- Reset shoot timer
            knight.shoot_timer = 0
            knight.weapon.shot = true
            add(
                knight_weapons, {
                    x = knight.weapon.x,
                    y = knight.weapon.y,
                    speed = knight.weapon.speed
                }
            )
        end
    end
end

function knights_reload()
    for knight in all(knights) do
        -- shoot every 30 frames
        if knight.reload_timer >= 30 then
            -- Reset reload timer
            knight.reload_timer = 0
            knight.weapon.shot = false
        end
    end
end