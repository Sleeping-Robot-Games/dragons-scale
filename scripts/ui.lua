function draw_health()
    for i = 0, player.hp - 1 do
        spr(3, i * 8 + 10, 0)
        print('HP:', 0, 2, 7)
    end
end

-- TODO: Text box between fights and for cinematics
-- TODO: Fire breath bar