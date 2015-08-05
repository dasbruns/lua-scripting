-- mybatmon
function myBats (mytextbox)
	bat = io.popen("/usr/bin/bat -p","r")
	text = bat:read("*a")
	io.close(bat)
	if text == '' then
		do text = "no bats oO"
			col = "darkgoldenrod"
			stat = '⚡'
			mytextbox:set_markup(string.format('<span color="%s">%s</span>',col, stat))
			return
	end
	else
		status, text = text:match("([^,]+),([^,]+)")
		text = tonumber(string.sub(text,1,-3))
		if text >= 98 then
			col = "darkgoldenrod"
		elseif text > 75 then
		 	col = "green"
		elseif text > 50 then
			col = "greenyellow"
		elseif text > 20 then
			col = "yellow"
		elseif text > 10 then
			col = "orange"
		else
			col = "red"
		end
		if status == 'charging' then
			stat = '⚡'
		else
			stat = ''
		end
	end
	mytextbox:set_markup(string.format('<span color="%s">%s%s%s</span>',col, stat, text, '%'))
end

mytextbox = wibox.widget.textbox()
myBats(mytextbox)
mytimer = timer({ timeout = 180 })
mytimer:connect_signal("timeout", function () myBats(mytextbox) end)
mytimer:start()
