player = {}
fireballs = {}
knights = {}
knight_weapons = {}
knight_timer = 0
rocks = {}

shake_duration = 0
shake_intensity = 0

function _init()
    init_player()

    -- DEBUG spawn first knight:
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

    update_rocks()

    -- particle effects
    for knight in all(knights) do
        -- ballons on fire
        update_particles(knight.balloon.fire_particles)
    end

    for fireball in all(fireballs) do
        -- fireball trails
        update_particles(fireball.fire_particles)
    end

    update_shake()
end

function _draw()
    apply_shake()

    -- Clear screen with blue background
    cls(12)

    -- TODO: Paralax dark green and mountain background

    draw_player()

    draw_fireballs()

    draw_knights()

    draw_thrown_knight_weapons()

    draw_rocks()

    draw_health()
end