player = {}
fireballs = {}
enemies = {}
enemy_timer = 0

function _init()
    player = {
        x = 10,
        y = 64,
        speed = 2
    }

    -- DEBUG:
    local y = rnd(128)
    add(
        enemies, {
            x = 84,
            y = y,
            start_y = y,
            offset = rnd(1000)
        }
    )
end

function _update()
    player_movement()

    shoot_fireball()

    spawn_enemies()

    move_enemies()

    -- Move fireballs
    for fireball in all(fireballs) do
        fireball.x += fireball.speed
    end

    -- Check collision between fireballs and enemies
    for fireball in all(fireballs) do
        for enemy in all(enemies) do
            local fireball_left = fireball.x - 2
            local fireball_right = fireball.x + 2
            local fireball_top = fireball.y - 2
            local fireball_bottom = fireball.y + 2

            local enemy_left = enemy.x
            local enemy_right = enemy.x + 8
            local enemy_top = enemy.y
            local enemy_bottom = enemy.y + 8

            if fireball_left < enemy_right
                    and fireball_right > enemy_left
                    and fireball_top < enemy_bottom
                    and fireball_bottom > enemy_top then
                del(fireballs, fireball)
                del(enemies, enemy)
            end
        end
    end
end

function _draw()
    -- Clear screen
    cls()

    -- Draw player
    draw_large_sprite(player.x, player.y, 1, 2)

    -- Draw fireballs
    for fireball in all(fireballs) do
        circfill(fireball.x, fireball.y, 2, 9)
    end

    -- Draw enemies
    for enemy in all(enemies) do
        -- Draw enemy
        spr(63, enemy.x, enemy.y)
        draw_weapon(enemy.x, enemy.y)
        draw_ballon(enemy.x, enemy.y)
    end

    -- Visualize hitboxes
    for fireball in all(fireballs) do
        rect(fireball.x - 2, fireball.y - 2, fireball.x + 2, fireball.y + 2, 8)
    end

    for enemy in all(enemies) do
        rect(enemy.x, enemy.y, enemy.x + 8, enemy.y + 8, 9)
    end
end