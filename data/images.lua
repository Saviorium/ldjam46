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

return Images