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
        hp = 5,
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
    end

    draw_health()
end