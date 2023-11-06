function spawn_particle(x, y, particles, life, vy_speed_range, vx_speed_range, vy_bias, vx_bias, color, size)
    add(
        particles, {
            x = x,
            y = y,
            color = flr(rnd(3)) + color, -- Random color between 8 (dark red) and 10 (yellow)
            size = rnd(size) + 1, -- Random size between 1 and 3
            life = life, -- Life duration of the particle
            vy = rnd(vy_speed_range) + vy_bias, -- Custom vertical velocity
            vx = rnd(vx_speed_range) + vx_bias -- Custom horizontal velocity
        }
    )
end

function update_particles(particles)
    for particle in all(particles) do
        particle.x += particle.vx
        particle.y += particle.vy
        particle.life -= 1
        if particle.life <= 0 then
            del(particles, particle)
        end
    end
end

function draw_particles(particles)
    for particle in all(particles) do
        circfill(particle.x, particle.y, particle.size, particle.color)
    end
end

function update_shake()
    if shake_duration > 0 then
        shake_duration -= 1
    end
end

function apply_shake()
    if shake_duration > 0 then
        local shake_x = rnd(shake_intensity * 2) - shake_intensity
        local shake_y = rnd(shake_intensity * 2) - shake_intensity
        camera(shake_x, shake_y)
    else
        -- Reset the camera if the shake is over
        camera(0, 0)
    end
end

-- TODO: Should save shakes for effects like the mage beams and boss battle
function trigger_shake(duration, intensity)
    shake_duration = duration
    shake_intensity = intensity
end