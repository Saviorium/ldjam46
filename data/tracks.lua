require 'love.audio'

local tracks = {}
--bip_on.wav --https://freesound.org/people/JustinBW/sounds/70107/
--radio_static.wav --https://freesound.org/people/GowlerMusic/sounds/262267/
--police_talk_1.wav --https://freesound.org/people/Guardian2433/sounds/320351/

tracks.list_of_sounds = {
}

function tracks.set_next_track( index, loaded_tracks )
	loaded_tracks[index]:play()
	loaded_tracks[index]:on("end", tracks.set_next_track( index, loaded_tracks ))
	index = index + 1 
end

function tracks.play_sound( sound )
	source = love.audio.newSource( sound.filepath, 'static' )
	source:setVolume(sound.volume)
	source:play()
	return source
end


return tracks