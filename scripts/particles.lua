function spawn_fire_particle(x, y, fire_particles, life, vy_speed_range, vx_speed_range, vy_bias, vx_bias)
    add(
        fire_particles, {
            x = x,
            y = y,
            color = flr(rnd(3)) + 8, -- Random color between 8 (dark red) and 10 (yellow)
            size = rnd(2) + 1, -- Random size between 1 and 3
            life = life, -- Life duration of the particle
            vy = rnd(vy_speed_range) + vy_bias, -- Custom vertical velocity
            vx = rnd(vx_speed_range) + vx_bias -- Custom horizontal velocity
        }
    )
end

function update_fire_particles(fire_particles)
    for particle in all(fire_particles) do
        particle.x += particle.vx
        particle.y += particle.vy
        particle.life -= 1
        if particle.life <= 0 then
            del(fire_particles, particle)
        end
    end
end

function draw_fire_particles(fire_particles)
    for particle in all(fire_particles) do
        circfill(particle.x, particle.y, particle.size, particle.color)
    end
end