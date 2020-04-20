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
Images.poligons = {asteroid_3 = 
			        { shape = "polygon",
			          polygon = {
					            { x = 0, y = 0 },
					            { x = 6, y = -9 },
					            { x = 17, y = -9 },
					            { x = 24, y = -6 },
					            { x = 39, y = 8 },
					            { x = 60, y = 18 },
					            { x = 80, y = 22 },
					            { x = 87, y = 27 },
					            { x = 87, y = 34 },
					            { x = 84, y = 40 },
					            { x = 85, y = 45 },
					            { x = 101, y = 49 },
					            { x = 109, y = 48 },
					            { x = 118, y = 51 },
					            { x = 124, y = 57 },
					            { x = 128, y = 60 },
					            { x = 130, y = 64 },
					            { x = 136, y = 70 },
					            { x = 131, y = 79 },
					            { x = 119, y = 81 },
					            { x = 83, y = 81 },
					            { x = 67, y = 78 },
					            { x = 42, y = 74 },
					            { x = 24, y = 69 },
					            { x = 14, y = 60 },
					            { x = 9, y = 53 },
					            { x = 9, y = 43 },
					            { x = 15, y = 32 },
					            { x = 15, y = 27 },
					            { x = 3, y = 12 }
			          }
			        
					}
				}

return Images