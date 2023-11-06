function spawn_rock()
    local rock = {
        x = 128 + rnd(32), -- Start x off-screen to the right
        y = 120 + rnd(32), -- Random start y near the bottom of the screen
        speed_x = -2, -- Speed for x, going left
        speed_y = -rnd(4) * 1, -- Initial vertical speed
        gravity = 0.05, -- Simulated gravity
        has_arced = false, -- Has the rock completed the arc?
        sprite_index = 1, -- start with the first sprite
        sprite_timer = 0, -- a timer to manage sprite changes
        sprites = { 26, 27, 28, 29 }, -- list of sprite indexes to cycle through
        animation_speed = 0.5 -- how fast the animation cycles
    }
    add(rocks, rock)
end

function update_rocks()
    -- Check if it's time to spawn a new rock
    if (#rocks == 0 or rocks[#rocks].x < 100) and rnd() < 0.1 then
        spawn_rock()
    end

    -- Move rocks along the x-axis and apply the curve
    for rock in all(rocks) do
        rock.x += rock.speed_x
        rock.y += rock.speed_y
        rock.speed_y += rock.gravity

        -- Check if the rock has completed its upward arc
        if not rock.has_arced and rock.speed_y >= 0 then
            rock.has_arced = true
        end

        -- If the rock has arced, it should only move downwards
        if rock.has_arced then
            rock.speed_y = max(rock.speed_y, 0)
        end

        rock.sprite_timer += rock.animation_speed
        if rock.sprite_timer >= #rock.sprites then
            rock.sprite_timer = 0
        end
        rock.sprite_index = flr(rock.sprite_timer) + 1

        -- Remove rock if it goes off screen
        if rock.x < -10 or rock.y > 128 then
            del(rocks, rock)
        end
    end
end

function draw_rocks()
    for rock in all(rocks) do
        spr(rock.sprites[rock.sprite_index], rock.x, rock.y)
    end
end