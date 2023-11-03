function damage_enemy(enemies, enemy)
    enemy.hp -= 1
    if (enemy.hp <= 0) del(enemies, enemy)
end