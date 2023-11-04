function player_movement()
    if (btn(0)) player.x = max(0, player.x - player.speed)
    if (btn(1)) player.x = min(128 - 16, player.x + player.speed)
    if (btn(2)) player.y = max(8, player.y - player.speed)
    if (btn(3)) player.y = min(128 - 8, player.y + player.speed)
    -- Start dashing
    if btnp(4) and not player.is_dashing then
        player.is_dashing = true
        player.dash_timer = 0
    end

    -- TODO: Make the dash a mechanic needed for the boss fight
    -- Perform dash
    if player.is_dashing then
        player.x = min(128 - 16, player.x + 5)
        player.dash_timer += 1

        -- Check if dash duration has been exceeded
        if player.dash_timer >= player.dash_duration then
            player.is_dashing = false
        end
    end

    -- Increment frame timer
    player.frame_timer += 1

    -- Decrease the invincibility timer if it's active
    if player.invincible_timer > 0 then
        player.invincible_timer -= 1
    end
end

function damage_player(dmg)
    -- Only apply damage if player is not invincible
    if player.invincible_timer <= 0 and not player.is_dashing then
        player.hp -= dmg
        player.invincible_timer = 30 -- Set player invincibility for 30 frames
    end
end

function heal_player(amount)
    player.hp = min(player.hp + amount, 6)
end

function shoot_fireball()
    -- TODO: Add cooldown. Unlock to make faster?
    if btnp(5) and player.invincible_timer <= 0 then
        add(fireballs, { x = player.x + 16, y = player.y + 2, speed = 3, fire_particles = {} })
        player.is_shooting = true
        player.frame_timer = 0
    end
end

-- TODO: Hold 5 to breath fire, this should be an unlockable ability

function draw_player()
    local top_wing_frames = { 1, 32, 48 }
    local bottom_wing_frames = { 17, 33, 49 }
    local mouth_frames = { 18, 16 }

    local wing_frame_count = #top_wing_frames
    local animation_speed = 10
    local wing_frame_idx = flr(time() * animation_speed) % (2 * wing_frame_count - 2) + 1

    -- Adjust index for pendulum animation
    if wing_frame_idx > wing_frame_count then
        wing_frame_idx = 2 * wing_frame_count - wing_frame_idx
    end

    local mouth_frame = mouth_frames[1]
    if player.is_shooting then
        if player.frame_timer < 5 then
            mouth_frame = mouth_frames[2]
        else
            player.is_shooting = false
        end
    end

    -- When dashing, hold the last frame
    if player.is_dashing then
        wing_frame_idx = wing_frame_count
        mouth_frame = mouth_frames[2]
    end

    -- Set the frames
    local top_wing_frame = top_wing_frames[wing_frame_idx]
    local bottom_wing_frame = bottom_wing_frames[wing_frame_idx]

    -- If player is invincible, toggle flashing state
    player.is_flashing = player.invincible_timer > 0 and flr(time() * 10) % 2 == 0

    -- Draw the player only if not flashing
    if not player.is_flashing then
        -- Draw the dragon
        spr(top_wing_frame, player.x, player.y - 8)
        spr(bottom_wing_frame, player.x, player.y)
        -- Top of head
        spr(2, player.x + 8, player.y - 8)
        -- Mouth
        spr(mouth_frame, player.x + 8, player.y)
    end
end

function draw_fireballs()
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
end