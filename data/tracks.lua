require 'love.audio'

local tracks = {}
--moo https://freesound.org/people/Yudena/sounds/377603/
tracks.list_of_sounds = {
	button = { filepath = "data/music/button.wav",
			   loopPoint = 0,
			   bpm = 160,
			   volume = 0.1
			 },

	error_button = { filepath = "data/music/error_button.wav",
					   loopPoint = 0,
					   bpm = 160,
					   volume = 0.1
					 },
	ship_start = { filepath = "data/music/ship_start.wav",
				   loopPoint = 0,
				   bpm = 160,
				   volume = 0.1
				 },
	shoot_1 = { filepath = "data/music/shoot_1.mp3",
			    loopPoint = 0,
			    bpm = 160,
			    volume = 0.1
			  }
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