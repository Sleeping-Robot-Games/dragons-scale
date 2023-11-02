function check_fireball_and_enemy_collision()
    -- Check collision between fireballs and enemies
    for fireball in all(fireballs) do
        for enemy in all(enemies) do
            -- Check collision with enemy
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

            -- Check collision with balloon
            local balloon_left = enemy.balloon.x
            local balloon_right = enemy.balloon.x + 16
            local balloon_top = enemy.balloon.y
            local balloon_bottom = enemy.balloon.y + 16

            if not enemy.balloon.popped
                    and fireball.x - 2 < balloon_right
                    and fireball.x + 2 > balloon_left
                    and fireball.y - 2 < balloon_bottom
                    and fireball.y + 2 > balloon_top then
                -- Collision with balloon logic here
                del(fireballs, fireball)
                enemy.balloon.popped = true
                -- Optionally: del(enemies, enemy)
            end
        end
    end
end

function check_player_and_enemy_collisions()
    for enemy in all(enemies) do
        local enemy_left = enemy.x
        local enemy_right = enemy.x + 8
        local enemy_top = enemy.y
        local enemy_bottom = enemy.y + 8

        local player_left = player.x + 4
        local player_right = player.x + 14
        local player_top = player.y + 4
        local player_bottom = player.y + 12

        if enemy.balloon.popped
                and player_left < enemy_right
                and player_right > enemy_left
                and player_top < enemy_bottom
                and player_bottom > enemy_top then
            del(enemies, enemy)
        end
    end
end