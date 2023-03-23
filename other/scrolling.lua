map_x=0

--since we start the map at 
--zero, then we have to update
function _update()
	map_x-=1
	if map_x<-127 then map_x=0 end
end

function _draw()
--clearing the screen
--and setting to color 12
--which is blue
	cls(12)
--16 pixels high and wide
	map(0,0,map_x,0,16,16)
	map(0,0,map_x+128,0,16,16)
end
