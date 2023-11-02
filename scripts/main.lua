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

    -- DEBUG spawn enemy:
    spawn_enemy()
end

function _update()
    player_movement()

    shoot_fireball()

    enemies_shoot()

    spawn_enemies()

    move_enemies()

    -- Move fireballs
    for fireball in all(fireballs) do
        fireball.x += fireball.speed
    end

    move_enemy_weapons()

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
        draw_weapon(enemy.weapon)
        draw_ballon(enemy.ballon)
    end
end