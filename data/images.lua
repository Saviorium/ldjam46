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
    	x = 22.94,
    	y = 40.79,
        polygon = {
            { x = 8, y = 68 },
            { x = 0, y = 51 },
            { x = 6, y = 33 },
            { x = 7, y = 18 },
            { x = 11, y = 5 },
            { x = 22, y = 1 },
            { x = 32, y = 5 },
            { x = 42, y = 28 },
            { x = 43, y = 62 },
            { x = 27, y = 81 }
        }
    },
    asteroid_2 = {
    	x = 37.52,
    	y = 41.42,
        polygon = {
            { x = 1, y = 28 },
            { x = 24, y = 3 },
            { x = 37, y = 1 },
            { x = 69, y = 25 },
            { x = 78, y = 36 },
            { x = 77, y = 51 },
            { x = 63, y = 71 },
            { x = 48, y = 76 },
            { x = 12, y = 72 },
            { x = 3, y = 61 }
        }
    },
    asteroid_3 = {
    	x = 58,
    	y = 55, -- 55
        polygon = {
            { x = 0, y = 7 },
            { x = 9, y = 0 },
            { x = 23, y = 4 },
            { x = 44, y = 23 },
            { x = 80, y = 33 },
            { x = 86, y = 38 },
            { x = 83, y = 54 },
            { x = 101, y = 61 },
            { x = 108, y = 59 },
            { x = 119, y = 62 },
            { x = 136, y = 80 },
            { x = 131, y = 90 },
            { x = 120, y = 91 },
            { x = 77, y = 90 },
            { x = 44, y = 85 },
            { x = 15, y = 72 },
            { x = 9, y = 55 },
            { x = 16, y = 39 },
            { x = 1, y = 19 }
        }
    },
    asteroid_4 = {
    	x = 24.48,
    	y = 23.63,
        polygon = {
            { x = 2, y = 18 },
            { x = 20, y = 0 },
            { x = 26, y = 7 },
            { x = 32, y = 7 },
            { x = 48, y = 23 },
            { x = 48, y = 30 },
            { x = 42, y = 37 },
            { x = 28, y = 42 },
            { x = 16, y = 42 },
            { x = 3, y = 27 }
        }
    },
    asteroid_5 = {
    	x = 20.95,
    	y = 15.25,
        polygon = {
            { x = 1, y = 21 },
            { x = 11, y = 1 },
            { x = 36, y = 1 },
            { x = 48, y = 9 },
            { x = 43, y = 18 },
            { x = 22, y = 18 },
            { x = 20, y = 34 },
            { x = 6, y = 36 }
        }
    }
}

return Images