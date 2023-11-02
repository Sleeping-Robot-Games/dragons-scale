player = {}
fireballs = {}
enemies = {}
weapons = {}
enemy_timer = 0

function _init()
    player = {
        x = 10,
        y = 64,
        speed = 2,
        is_dashing = false,
        dash_timer = 0,
        dash_duration = 10
    }

    -- DEBUG spawn enemy:
    spawn_enemy()
end

function _update()
    player_movement()

    shoot_fireball()
    -- Move fireballs
    for fireball in all(fireballs) do
        fireball.x += fireball.speed
    end

    enemies_shoot()
    enemies_reload()

    spawn_enemies()
    move_enemies()
    move_enemy_weapons()

    check_fireball_and_enemy_collision()
    check_player_and_enemy_collisions()
end

function _draw()
    -- Clear screen
    cls()

    draw_player()

    -- Draw fireballs
    for fireball in all(fireballs) do
        circfill(fireball.x, fireball.y, 2, 9)
    end

    -- Draw enemies
    for enemy in all(enemies) do
        -- Draw enemy
        spr(63, enemy.x, enemy.y)
        draw_balloon(enemy.balloon)
        if (not enemy.weapon.shot) draw_weapon(enemy.weapon)
    end

    for weapon in all(weapons) do
        draw_weapon(weapon)
    end
end