local Images = {}

for i=1, 5 do
    Images['empty_'..i] = love.graphics.newImage('data/images/asteroid/empty_'..(i)..'.png')
    Images['empty_'..i]:setFilter("nearest", "nearest")
    Images['iron_'..i] = love.graphics.newImage('data/images/asteroid/iron_'..(i)..'.png')
    Images['iron_'..i]:setFilter("nearest", "nearest")
    Images['ice_'..i] = love.graphics.newImage('data/images/asteroid/ice_'..(i)..'.png')
    Images['ice_'..i]:setFilter("nearest", "nearest")
    Images['all_'..i] = love.graphics.newImage('data/images/asteroid/all_'..(i)..'.png')
    Images['all_'..i]:setFilter("nearest", "nearest")
end

for i=1, 6 do
    Images['star_'..i] = love.graphics.newImage('data/images/star/star_'..(i)..'.png')
    Images['star_'..i]:setFilter("nearest", "nearest")
end
Images.poligons = {
    asteroid_1 = {
        x = 8,
        y = 70,
        polygon = {
            { x = 0, y = -2 },
            { x = -8, y = -19 },
            { x = -2, y = -37 },
            { x = -1, y = -52 },
            { x = 3, y = -65 },
            { x = 14, y = -69 },
            { x = 24, y = -65 },
            { x = 34, y = -42 },
            { x = 35, y = -8 },
            { x = 19, y = 11 }
        }
    },
    asteroid_2 = {
        x = 1,
        y = 28,
        polygon = {
            { x = 1, y = 0 },
            { x = 24, y = -25 },
            { x = 37, y = -27 },
            { x = 69, y = -3 },
            { x = 78, y = 8 },
            { x = 77, y = 23 },
            { x = 63, y = 43 },
            { x = 48, y = 48 },
            { x = 12, y = 44 },
            { x = 3, y = 33 }
        }
    },
    asteroid_3 = {
        x = 0,
        y = 9,
        polygon = {
            { x = 0, y = -2 },
            { x = 9, y = -9 },
            { x = 23, y = -5 },
            { x = 44, y = 14 },
            { x = 80, y = 24 },
            { x = 86, y = 29 },
            { x = 83, y = 45 },
            { x = 101, y = 52 },
            { x = 108, y = 50 },
            { x = 119, y = 53 },
            { x = 136, y = 71 },
            { x = 131, y = 81 },
            { x = 120, y = 82 },
            { x = 77, y = 81 },
            { x = 44, y = 76 },
            { x = 15, y = 63 },
            { x = 9, y = 46 },
            { x = 16, y = 30 },
            { x = 1, y = 10 }
        },
    },
    asteroid_4 = {
        x = 1,
        y = 18,
        polygon = {
            { x = 1, y = 0 },
            { x = 19, y = -18 },
            { x = 25, y = -11 },
            { x = 31, y = -11 },
            { x = 47, y = 5 },
            { x = 47, y = 12 },
            { x = 41, y = 19 },
            { x = 27, y = 24 },
            { x = 15, y = 24 },
            { x = 2, y = 9 }
        }
    },
    asteroid_5 = {
        x = 1,
        y = 27,
        polygon = {
          { x = 0, y = -5 },
          { x = 10, y = -25 },
          { x = 35, y = -25 },
          { x = 47, y = -18 },
          { x = 42, y = -8 },
          { x = 21, y = -8 },
          { x = 19, y = 8 },
          { x = 6, y = 9 }
        }
    }
}

return Images