function check_fireball_and_enemy_collision(enemies)
    -- Check collision between fireballs and knights
    for fireball in all(fireballs) do
        for enemy in all(enemies) do
            if enemy.type == 'knight' and enemy.balloon.popped then goto continue end

            -- Check collision with enemy
            local fireball_left = fireball.x - 2 local fireball_right = fireball.x + 2
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
                damage_enemy(enemies, enemy)
            end

            ::continue::
        end
    end
end

function check_fireball_and_ballon_collision()
    for fireball in all(fireballs) do
        for knight in all(knights) do
            -- Check collision with balloon
            local balloon_left = knight.balloon.x
            local balloon_right = knight.balloon.x + 16
            local balloon_top = knight.balloon.y
            local balloon_bottom = knight.balloon.y + 16

            if not knight.balloon.popped
                    and fireball.x - 2 < balloon_right
                    and fireball.x + 2 > balloon_left
                    and fireball.y - 2 < balloon_bottom
                    and fireball.y + 2 > balloon_top then
                -- Collision with balloon logic here
                del(fireballs, fireball)
                knight.balloon.hp -= 1
                -- TODO: Add fire particle effects to damaged ballons in a draw function
                if (knight.balloon.hp <= 0) knight.balloon.popped = true
            end
        end
    end
end

function check_player_and_knight_collisions()
    for knight in all(knights) do
        local knight_left = knight.x
        local knight_right = knight.x + 8
        local knight_top = knight.y
        local knight_bottom = knight.y + 8

        local player_left = player.x + 4
        local player_right = player.x + 16
        local player_top = player.y - 4
        local player_bottom = player.y + 4

        if knight.balloon.popped
                and player_left < knight_right
                and player_right > knight_left
                and player_top < knight_bottom
                and player_bottom > knight_top then
            del(knights, knight)
        end
    end
end