player = {}
fireballs = {}
knights = {}
knight_weapons = {}
knight_timer = 0

function _init()
    player = {
        x = 10,
        y = 64,
        speed = 2,
        hp = 6,
        invincible_timer = 0,
        is_flashing = false,
        is_dashing = false,
        dash_timer = 0,
        dash_duration = 10,
        is_shooting = false,
        frame_timer = 0,
        wing_state = 1
    }

    -- DEBUG spawn knight:
    spawn_knight()
end

function _update()
    player_movement()

    shoot_fireball()
    -- Move fireballs
    for fireball in all(fireballs) do
        fireball.x += fireball.speed
    end

    knights_shoot()
    knights_reload()

    spawn_knights()
    move_knights()
    move_knight_weapons()

    check_player_and_knight_weapon_collisions()
    check_fireball_and_enemy_collision(knights)
    check_fireball_and_ballon_collision()
    check_player_and_knight_collisions()

    -- particle effects
    for knight in all(knights) do
        update_fire_particles(knight.balloon.fire_particles)
    end

    for fireball in all(fireballs) do
        update_fire_particles(fireball.fire_particles)
    end
end

function _draw()
    -- Clear screen with blue background
    cls(12)

    draw_player()

    -- Draw fireballs
    for fireball in all(fireballs) do
        circfill(fireball.x, fireball.y, 2, 9)
        spawn_fire_particle(
            fireball.x,
            fireball.y,
            fireball.fire_particles,
            6,
            1,
            2,
            -.5,
            1
        )
        draw_fire_particles(fireball.fire_particles)
    end

    -- Draw knights
    for knight in all(knights) do
        -- Draw knight
        if knight.balloon.popped then
            spr(62, knight.x, knight.y)
        else
            spr(63, knight.x, knight.y)
        end
        draw_balloon(knight.balloon)
        if knight.balloon.hp < 2 and not knight.balloon.popped then
            spawn_fire_particle(
                knight.balloon.x + 8,
                knight.balloon.y + 8,
                knight.balloon.fire_particles,
                8,
                1,
                2,
                -1,
                -0.25
            )
            draw_fire_particles(knight.balloon.fire_particles)
        end
        if (not knight.weapon.shot) draw_knight_weapon(knight.weapon)
    end

    for weapon in all(knight_weapons) do
        draw_knight_weapon(weapon)

        local weapon_left = weapon.x
        local weapon_right = weapon.x + 6
        local weapon_top = weapon.y + 2
        local weapon_bottom = weapon.y + 6
        rect(weapon_left, weapon_top, weapon_right, weapon_bottom, 7) -- 8 is red color
    end

    -- Draw player hitbox (for visualization)
    local player_left = player.x + 4
    local player_right = player.x + 16
    local player_top = player.y - 4
    local player_bottom = player.y + 4
    rect(player_left, player_top, player_right, player_bottom, 7)
    -- 11 is yellow color

    draw_health()
end