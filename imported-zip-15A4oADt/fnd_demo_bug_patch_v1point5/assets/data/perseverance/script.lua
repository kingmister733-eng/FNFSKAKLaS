
local allowEnd = false
function onEndSong()
	if not allowEnd and isStoryMode then
		startVideo('afterperseverance_cutscene')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end

local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		startVideo('DUSTTALE_CUTSCENE_HAHA')
		allowCountdown = true
		return Function_Stop;
	end
	return Function_Continue;
end