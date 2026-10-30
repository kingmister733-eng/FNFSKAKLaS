local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		startVideo('PAPYRUSPLEASELEAVEMYHEAD')
		allowCountdown = true
		return Function_Stop;
	end
	return Function_Continue;
end

local allowEnd = false
function onEndSong()
	if not allowEnd and isStoryMode then
		startVideo('end_demo')
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end