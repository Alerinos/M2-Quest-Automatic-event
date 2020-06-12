function secondsToTime(seconds)
	if seconds <= 60 then
		return string.format("%d sekund", seconds)
	else
		local minutes = math.floor(seconds / 60)
		seconds = math.mod(seconds, 60)
		if minutes <= 60 then
			return string.format("%d minut, %d sekund", minutes, seconds)
		else
			local hours = math.floor(minutes / 60)
			minutes = math.mod(minutes, 60)
			if hours <= 24 then
				return string.format("%d godzin, %d minut ", hours, minutes)
			else
				local days = math.floor(hours / 24)
				hours = math.mod(hours, 24)
				return string.format("%d dni, %d godzin ", days, hours)
			end
		end
	end
end