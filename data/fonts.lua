local fonts = {
	numbers = love.graphics.newFont("data/fonts/CursedTimerUlil-Aznm.ttf", 11 ), -- https://www.fontspace.com/heaven-castro/cursed-timer-ulil Freeware
	char    = love.graphics.newFont("data/fonts/CustomFontTtf12H20-mLWya.ttf", 12*scale),
	smallNumbers = love.graphics.newFont("data/fonts/CustomFontTtf12H20-mLWya.ttf", 27 )
}
fonts.numbers:setFilter( "nearest", "nearest" )
fonts.char:setFilter( "nearest", "nearest" )
fonts.smallNumbers:setFilter( "nearest", "nearest" )
return fonts