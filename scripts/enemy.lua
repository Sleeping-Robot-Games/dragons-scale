function damage_enemy(enemies, enemy)
    enemy.hp -= 1
    -- Set to flash for 10 frames
    enemy.damage_timer = 10
    if (enemy.hp <= 0) del(enemies, enemy)
end