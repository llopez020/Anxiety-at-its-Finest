pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
-- init - called on run`
function _init()
cls()

objlist=nil

#include collision.lua
#include animation.lua

--debug switch
debugint=1 -- shows collision boxes and coords
debugprint=0 -- shows object list

--animation test vars
start_animate = 1
sprite_animation = {24,25}
anxiety_animation = {64,72,128,136,128,72}
anxiety_animation2 = {64,72,128,136,128,72}
anxiety_animation3 = {64,72,128,136,128,72}
bounce = 0
--


grav=2 -- gravity unused
gravspd=2 -- gravity unused
mapx=0 -- map x pos
mapy=0 -- map y pos
oldmapx=0 -- map pos in previous frame
oldmapy=0 -- map pos in previous frame


mapwidth=30 -- map width
mapheight=30 -- map height

spd=.5 -- movement speed

mode = "initdebug" -- sets mode to debug menu

loadmap() -- converts pico-8 map into objects

player = create_object("player",0,0,0,4,7) -- creates player object with sprite 0

palt(11, true) -- green color as transparency is true
palt(0, false) -- black color as transparency is false

--Jumping Mecahinc
jump_height = 0
y_force = 0
jump_allowed = true


end
-->8
-- update - called on every frame
function _update60()

if mode=="initdebug" then initdebug() end -- debug menu
if mode=="test" then testmode() end -- game test
if mode=="test2" then testmode2() end -- anim test
if mode=="test3" then testmode3() end -- Gravity with landing particles 


end
-->8
-- test - test mode
function testmode()

cls()

drawallobj() -- draws objects on to screen

-- fps debug
if debugint==1 then print(stat(7).." fps\n",0,0,7) end

-- sets initial pos, should not be changed
player.oldx=player.x player.oldy=player.y olddmapx=mapx olddmapy=mapy

-- print object list
if debugprint==1 then printlist() end

-- player movement controls: updates player pos, map pos, and then checks for collision. if collides, sends back to old position
if btn(1) then player.x=player.x+spd mapx+=.125*spd checkallcol(player,0) end
if btn(0) then player.x=player.x-spd mapx-=.125*spd checkallcol(player,0) end
if btn(2) then player.y=player.y-spd mapy-=.125*spd checkallcol(player,1) end
if btn(3) then player.y=player.y+spd mapy+=.125*spd checkallcol(player,1) end

-- unfinished gravity code
//if checkallcol(player)==false then player.y=player.y+grav mapy+=.125*grav checkallcol(player) end
//if player.y==player.oldy then player.y=player.y-gravspd end

-- moves map if player is in middle of screen
if player.x<0 then player.x=0 end
if player.x>=128-player.width then player.x=128-player.width end
if player.x>64 and mapx<mapwidth-8 then player.x=64 end
if player.x<64 and mapx>=0+8 then player.x=64 end
if player.y<0 then player.y=0 end
if player.y>=128-player.height then player.y=128-player.height end
if player.y>64 and mapy<mapheight-8 then player.y=64 end
if player.y<64 and mapy>=0+8 then player.y=64 end


-- moves all objects to correct map position
if player.x==64 and player.x==player.oldx and player.x!=0 then moveallx() end
if player.y==64 and player.y==player.oldy and player.y!=0 then moveally() end

-- prints map pos
print((ceil(mapx*8)).." "..ceil(player.x),40,0,7)
print((ceil(mapy*8)).." "..ceil(player.y),40,9,7)

end


-- moves all objects in the x direction if not player
function moveallx()
 	local temp = objlist
		while temp do
			if (player.id!=temp.value.id) then temp.value.x=temp.value.x+((olddmapx-mapx)*8) end
			temp = temp.next
		end
end


-- moves all objects in the y direction if not player
function moveally()
 	local temp = objlist
		while temp do
			if (player.id!=temp.value.id) then temp.value.y=temp.value.y+((olddmapy-mapy)*8) end
			temp = temp.next
		end
end


-- draws all nearby objects
function drawallobj()
 	local temp = objlist
		while temp do
			if temp.value.x>0-32 and temp.value.x<128-8+32 and temp.value.y>0-32 and temp.value.x<128-8+32 then temp.value.draw(temp.value) end
			temp = temp.next
		end
end


-- checks if object collides. if so, revert object to last position depending on x_y
-- checkallcol(obj1 = object to be checked, x_y = direction to be checked (0 = x, 1 = y))
function checkallcol(obj1,x_y)
 	local temp = objlist
		-- go through object list
		while temp do
		 -- if object is too far, skip
		 if (abs(obj1.x-temp.value.x)>obj1.width*2 or abs(obj1.y-temp.value.y)>obj1.height*2) then goto continue end
			
			-- if object is not the object being checked, check for collision
			if (obj1.id!=temp.value.id and checkcol(obj1, temp.value,x_y)==true) then	return true end
			::continue::
			temp = temp.next
		end

		-- if object is not the player, update oldx and oldy depending on x_y
		if obj1.id!="player" then if x_y == 0 then obj1.oldx=obj1.x else obj1.oldy=obj1.y end end

  -- if object is player, update olddmap
		if obj1.id=="player" then oldmapx=mapx oldmapy=mapy end 

		-- no collision occurred
		return false
end

-- checks for collision between two objects
function checkcol(obj1, obj2,x_y)
 bool = sprcoll(obj1.x,obj1.y,obj1.width,obj1.height,obj2.x,obj2.y,obj2.width,obj2.height)
 
 -- if collision occurs, send back to old pos based on x_y, else return false
	if bool==true then if x_y==0 then obj1.x=obj1.oldx else obj1.y=obj1.oldy end
			if obj1.id=="player" then mapx=oldmapx mapy=oldmapy end 
	end 
	
	return bool
end
 
function testmode2()

cls(14)

print"hello, this is a test mode."
--begin animation showcase
if(start_animate == 1) then
	animate_once(30,30,{0,1,2},1,1,30,2)
	animate_once(30+8,30,{3,4,5},1,1,15,3)
	animate_once(30+8+8,30,{6,7,8},1,1,15,2)
	animate_once(30+8+8+8,30,{6,7},1,1,10,2)
	for i = 1, 5 do
		animate_once(
			-40-flr(rnd(32)),
			100,
			{72,128,136,128},
			8,
			4,
			flr(rnd(5))+5,
			2)
	end
	start_animate = 0
end
print("these animations are called once",0,30+8)
print("animations currently playing: "..#animation_data_once,0,30+8+8)
if(#animation_data_once == 0) then
	start_animate = 1
end

animate(sprite_animation,30,30+8+8+8,sprite_animation,1,1,10)
animate(anxiety_animation,sin(bounce)*4-4,96,anxiety_animation,8,4,5)
animate(anxiety_animation2,sin(bounce)*4-4,105,anxiety_animation2,8,4,11)
animate(anxiety_animation3,sin(bounce)*4-4,115,anxiety_animation3,8,4,17)
if(bounce > 1) then
	bounce = 0
else
	bounce = bounce + 0.010
end
print("this animation is continuous",0,30+8+8+8+8)
print("this animation combines both",0,91)

handle_animations()
--end animation showcase
end

function initdebug()

cls()

print"press 🅾️ for mode 1,\npress ❎ for mode 2 \n press down arrow for mode 3"

if btn(4) then mode = "test" end
if btn(5) then mode = "test2" end
if btn(3) then mode = "test3" end -- Mode 3 for testing 


end

function loadmap()
	for i=0,mapwidth,1 do
		for j=0,mapheight,1 do
		 if (mget(i,j)!=0) then create_object("wall",mget(i,j),i*8,j*8,8,8) end
	 end
	end
end

-->8
-- Test mode 3 for objects 
function testmode3()

cls() --Clearing the screen

drawallobj() --This function draws all the items in the screen

if debugint==1 then print(stat(7).." fps\n",0,0,7) end

spd=1
-- X cordinate movement
if btn(1) then player.x=player.x+spd checkallcol(player) mapx+=.125*spd end
if btn(0) then player.x=player.x-spd checkallcol(player) mapx-=.125*spd end
-- Y cordinate movement


if btn(2) and jump_height < 10 and jump_allowed 
then player.y=player.y-spd checkallcol(player) mapy-=.125*spd 
y_force = -3 
jump_height += 1
else 
if not checkallcol(player) then
player.y = player.y - y_force checkallcol(player)
end
if jump_height == 10 or not jump_allowed and checkallcol(player) then 

	jump_allowed = false
	jump_height = 0 
	y_force -=1

end 
end




if btn(3) then player.y=player.y+spd checkallcol(player) mapy+=.125*spd end






function moveallx()
	local temp = objlist
	   while temp do
		   if (player.id!=temp.value.id) then temp.value.x=temp.value.x+(8*(oldmapx-mapx)) end
		   temp = temp.next
	   end
end

function moveally()
	local temp = objlist
	   while temp do
		   if (player.id!=temp.value.id) then temp.value.y=temp.value.y+(8*(oldmapy-mapy)) end
		   temp = temp.next
	   end
end

function drawallobj()
	local temp = objlist
	   while temp do
		   temp.value.draw(temp.value)
		   temp = temp.next
	   end
end

function checkallcol(obj1)
	local temp = objlist
	   while temp do
		if (abs(obj1.x-temp.value.x)>obj1.width*2 or abs(obj1.y-temp.value.y)>obj1.height*2) then goto continue end
		   if (obj1.id!=temp.value.id and checkcol(obj1, temp.value)==true) then return end
		   ::continue::
		   temp = temp.next
	   end
	   obj1.oldx=obj1.x
	   obj1.oldy=obj1.y
end

function checkcol(obj1, obj2)
bool = sprcoll(obj1.x,obj1.y,obj1.width,obj1.height,obj2.x,obj2.y,obj2.width,obj2.height)
   if bool==true then obj1.x=obj1.oldx obj1.y=obj1.oldy end 
   return bool
end




end ---- END MODE 3  


-->8
-- create_object(unique id,sprite number, x position, y position, object width, object height)
function create_object(uid,rsprite,rx,ry,rwidth,rheight)
a={
oldx = rx, --previous x
oldy = ry, --previous y
sprite=rsprite, --sprite number
x=rx, --x position
y=ry, --y position
width=rwidth, --object width
height=rheight, --object height
id=uid, --unique id
mapx, --map x pos
mapy -- map y pos
}

 -- draws obj
	function a.draw(obj)
		spr(obj.sprite,obj.x,obj.y,obj.width/8,obj.height/8)
	end

addtolist(a)

return a
end

 
function addtolist(a)
 	objlist= {
 		next=objlist,
 		value=a
 	}
 	print("added object"..a.sprite)
end
 
 function printlist()
  local temp = objlist
  local temp2 = 0
  print("object list:")
		while temp do
			print(temp.value.id)
			temp = temp.next
			temp2+=1
			if temp2>16 then return end
		end
	end
	
__gfx__
0440bbbb04bbbbbb40bbbbbbb04bbbbbbb04bbbb04bbbbbb04bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbcbbbbcbb88bbbbb88bbbbbb666666665555555555555555
0ff0bbbb0fbbbbbbf0bbbbbbb0fbbbbbbb0fbbbb0fbbbbbb0fbbbbbb04bbbbbbbbbbbbbbf44fbbbbcbcbbcbcb44bbbbb44bbbbbb660660665566666666666675
1111bbbb11bbbbbb11bbbbbb111bbbbbb111bbbb11bbbbbb11bbbbbb0fbbbbbbbbbbbbbb1ff1bbbbcbc00cbc8888bbbb88bbbbbb666666665556666666666775
1111bbbb11bbbbbb11bbbbbbf11fbbbbbf11fbbb11bbbbbb11bbbbbb11fbbbbbbbbbbbbb1111bbbbcb0440bc4884bbbb48bbbbbb666666665555666666667775
fddfbbbbfdbbbbbbdfbbbbbbbddbbbbbbbddbbbbfdbbbbbbfdbbbbbb11bbbbbbbbbbbbbbb11bbbbbcb1111bc4114bbbb41bbbbbb006666065555566666677775
bddbbbbbbdbbbbbbdbbbbbbb0dbdbbbbbdbbdbbbddbbbbbbbdbbbbbbdddbbbbb4f11dbbbbddbbbbbcb1ff1bcb11bbbbbb1bbbbbb660000665555556666777775
b00bbbbbb0bbbbbb0bbbbbbbbbb0bbbb0bbb0bbb00bbbbbbb0bbbbbbbb0bbbbb0011fd0bb00bbbbbcbb44bbcb88bbbbbb8bbbbbb666666665555555667777775
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb666666665555555577777775
88bbbbbbb00bbbbb00bbbbbb00bbbbbbb44bbbbbb44bbbbb44bbbbbbb55bbbbbb55bbbbb55bbbbbbb44bbbbb44bbbbbb44bbbbbbb4bb9bbb5555555577777775
44bbbbbbbffbbbbbffbbbbbbffbbbbbbbffbbbbb4ffbbbbbff4bbbbbbffbbbbb5ffbbbbbff5bbbbbb44bbbbb44bbbbbb44bbbbbb49bbb4bb5555555667777775
88bbbbbbf88fbbbbf8bbbbbb8fbbbbbbf33fbbbb4f3bbbbb3f4bbbbb0000bbbb500bbbbb005bbbbb0000bbbb00bbbbbb00bbbbbb44449bbb5555556666777775
84bbbbbbf88fbbbbf8bbbbbb8fbbbbbbf33fbbbbbf3bbbbb3fbbbbbb7007bbbbb70bbbbb07bbbbbb7007bbbb70bbbbbb07bbbbbbb499bbbb5555566666677775
14bbbbbbf11fbbbbf1bbbbbb1fbbbbbbf11fbbbbbf1bbbbb1fbbbbbbf00fbbbbbf0bbbbb0fbbbbbb4004bbbb40bbbbbb04bbbbbbb4b9bbbb5555666666667775
1bbbbbbbbffbbbbbbfbbbbbbfbbbbbbbb11bbbbbbb1bbbbb1bbbbbbbb00bbbbbbb0bbbbb0bbbbbbbb00bbbbbb0bbbbbb0bbbbbbbbbbbbbbb5556666666666775
8bbbbbbbb88bbbbbb8bbbbbb8bbbbbbbbffbbbbbbbfbbbbbfbbbbbbbb00bbbbbbb0bbbbb0bbbbbbbb00bbbbbb0bbbbbb0bbbbbbbbbbbbbbb5566666666666675
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb5555555555555555
b4bb4bbbb4bbbbbbb0bbbbbbb0bb0bbbb9b9bbbbbfbbfbbbbbbbfbbbb000000bb000000b000bbbbbbbbcbbbbb000000bbbbcccccbbbbbb0b0000000000000000
44bbb4bb49bbb9bb00bbbbbb00bbb0bb9fbbfbbbffbbbfbbbbfbbfbb0477774001111110090bbbbbbbbcbbbb04444440bbc77777bbbbb0300000000000000000
44444bbb99494bbb00000bbb00000bbbff9ffbbbfffffbbbffbbbfbb0747747001000001090bbbbbbbcccbbb0ffffff0bbc777c7bbbb03300000000000000000
b444bbbbb949bbbbb000bbbbb000bbbbbf9fbbbbbfffbbbbfffffbbb0774477001011101090bbbbbbbcccbbb000ff000bbc77c7700b0330b0000000000000000
b4b4bbbbb9b9bbbbb0b0bbbbb0b0bbbbbfbfbbbbbfbfbbbbbfffbbbb0774477001000101090bbbbbbcccccbb0ccffcc0bbbcc77c330330bb0000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbfbfbbbb0747747001111101000bbbbbcccc7ccb0cf88fc0bbc7777c03330bbb0000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0477774000000001090bbbbbccc77ccbbcf88fcbbc777ccbb030bbbb0000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb000000bb111111b000bbbbbbcccccbbbbffffbbcccccbbbbb0bbbbb0000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbb000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbb00bbb0000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb000000000050bbbbbbbbbbbbbbbbbb0000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbb00bbbbb000bbbbbbbbbbbbbbbbbbbbbbbbbbbbb000555555550bbbbbbbbbbbbbbbbbb00bbb000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbb00bb0bbb00bbbbbbbbbbbbbbbbbbbbbbbbbbbb005500000000bbbbbbbbbbbbbbbbbbbbbbbbb00500bbbbbbbbbbbbbbbbbbbbbbbbbbb000bbbbbb
bbbbbbbbbbbb00000bbbb00bbbbbbbbbbb00000bbbbbbbbbb005000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0500bbbbbbbbbbbbbbbbbbbbbbbbb00000000bbb
bbbbbbbbbbbb00000bbbb00bbbbbbbbbbb00000bbbbbbbbbb005000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0500bbbbbbbbbb0000bbbbbbbbbb0055555500bb
bbbbbbbbbbbbbb00bbbbb000bbbbbbb00000000000bbbbbbb05000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0500bbbbbbb00055500bbbbbbbb005500000500b
bbbbbbbbbbbbbbbbbbbbb000bbbbb00000bbbbbb0000bbbbb05000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000bbbbbb00555c5500bbbbbbb0000bbb00000b
bbbbbbbbbbbbbbbbbbbbb000bbbbb00bbbbbbbbbb000bbbbb050bbbb0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb050bbbbbbb00500000000bbbbbbb00bbbbbbbb000
bbbbbbbbbbbbbbbbbbbb0000bbbb000bbbbbbbbbbb000bbbb05000000bbbbbbbbbbbbbbbb00bbbbbbbbbbb0000bbbbb0000000bbbbb00bbbbbb0bbbbbbbbbb00
bbbbbbbbbbbbbbbbbbb0000bbb0000bbbb00000bbb050bbbb0055550bbbbbbbbbbbbbbbb0bbbbbbbbbbbbb050bbbbbb0000bbbbbbbb00bbbbbbbbbbbbbbbbbb0
bbbb00000000bbbb000000bbb0000bbbb000bb00bb050bbbbb00000bbbbbbbbbbbbbbbb0bbbbbbbbbbbbb0000bbbbb0000bbbbbbbbb00bbbbbbbbbbbbbbbbbb0
bb0000000000000000000bb000000bbbb00bbbb0bb050bbbbbbbbbbbbbbbbbbbbbbbbb000bbbbbbbbbbb0000bbbb000000bbbbbbbbb00bbbbbbbbbbbbbbbbbbb
b000000005550000000000000000bbbbb0bbb000b0550bbbbbbbbbbbbbbbbbbbbbbb00000000bbbbb000000bbb0000000bbbbbbbbbb00bbbbbbbbbbbbbbbbbbb
000050005500000000000005500bbbbbb0bbbbbbb0500bbbbbbbbbbbbbbbbbbbbb00000000000000000000bb00000500bbbbbbbbbb00bbbbbbbbbbbbbbbbbbbb
055550005555555500005555000bbbbbb00bbbbb0500bbbbbbb00000bb0bbbbbb0000000550000000000000000555000bbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbb
055550005555555500005555000bbbbbb00bbbbb0500bbbbbbb00000bb0bbbbb000055555c500000000000005555500bbbbbbbbbbbbbbbbbbbbbbb0000bbbbbb
550000000000005550005cc50000bbbbb000bb00550b7bbbb0000000bb0bbbbb0555555555c5005550000555cc55000bbbbbbbbbbbbbbbbbbbbbb00000bbbbbb
500000000000000555005c5000000bbbbb00000550bbbbbb00000000000bbbbb555c550005550005550005ccc500000bbbbbbbbbbbbbbb7bbbbb000bb000bbbb
0000055555555005c5005500000000bbbbb000000bbbbbb00000bb0000bbbbbbcccc550000000000055005c550000000bbbbbbbbbbbbbbbbbbb000bbb000bbbb
0005555ccc555005c5005000550000bbbbbbbbbbbbbbbb000bbbbbbbbbbbbbbbccc55555555550000550055000000000bbbbbbbbbbbbbbbbbb000bbbb0bbbbbb
00555ccccccc555555050055cc55500bbbbbbbbbbbbbb000bbbb000bbbbbbbbbcc555555ccc550055550050005550000bbbbbbbbbbbbbbbbb000bbbbbbbbbbbb
0555cccc55555555500005ccc555550000bbbbbbbbbb0000bbbbbb00bbbbbbbbcc5555cccccc55555c5050055ccc55500bbbbbbbbbbbbbb0000bbbbbbbbbbbbb
555ccc555000000000005cc5500005500000bbbbbb0000000bbbbb00bbbbbbbbcc55ccccc55555555500005ccc55c555000bbbbbbbbbbb00000bbbbbbbbbbbbb
55cccc550000000000055cc50000000000000b000000000000bb0000bbbbbbbbccccccc555000000000005cc55000005500000bbbbbb00000000bbbbbbbbbbbb
5cccc55500000000555cc5500555500005500000000005500000000bbbbbbbbbccccccc550000000000055cc500000000000000b0000000000000bbbbbbbbbbb
ccccc5555500005555cc55500005c0055500000000005000000000bbbbbbbbbbcccccc55500000000555cc5500555550005500000000000555000000bbbbbbbb
ccccc5555500005555cc55500005c0055500000000005000000000bbbbbbbbbbcccccc5555500055555cc555000005c00550000000000050000000000bbbbbbb
ccccccc5555555555ccc55500005c50555555500000550000bbbbbbbbbbbbbbbcccccccc5555555555ccc555000005c505555555005005500000bbb00bbbbbbb
cccccccc5555555cccccc5550005c50000555c500005500bbbbbbbbbbbbbbbbbccccccccc555555ccccccc55500005c5000555cc5555055000bbbbbb0bbbbbbb
cccccccccccccccccccccc5555cccc5550005c50005c500bbbbbbbbbbbbbbbbbccccccccccccccccccccccc55555cccc5500005cccc55c5000bbbbbb0bbbbbbb
ccccccccccccccccccccccccccccccc55555ccc505cc500bbbbbbbbbbbbbbbbbccccccccccccccccccccccccccccccccc55555cccccccc5000bbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbb00000000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbb000bbb00000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0005500bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbb0050bbbbbbbbbbbbbbbbbbbbbbbbbb000bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb000000050bbbbbbbbbbbbbbbbbbbbbb00bbbbbbb
bbbbbbbbbbbbbbbbbbbbbb050bbbbbbbbbbbbbbbbbbbbbbbbbb05500bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00bbbbbb000bbbbbbbbbbbbbbbbbbbbbbb000bbbb
bbbbbbbbbbbbbbbbbbbbbb050bbbbbbbbbbbbbbbbbbbbbbbbbbb05550bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0bbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbb000bbb
bbbbbbbbbbbbbbbbbbbbbb050bbbbbbbbbbbbbbbbbbbbbbbbbbbb00550bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00bb
bbbbbbbbbbbbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbbbbbbbbbbbb0050bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00bb00bb
bbbbbbbbbbbbbbbbbbbbb050bbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbbb0bb00bb
bbbbbbb000bbbbbbbbbb0000bbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbbbbb0bbb
bbbbb000000bbbbbbbbb050bbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbb00000bbbbbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbb00bbbb
bbbbb000b000bbbbbbb0000bbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb00000000bbbbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbbbbbbbb
bbbb000bbbb0bbbbbb0000bbbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb0000555000bbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbbbbbbbbb
bbb0050000b00b0000000bbbbbbbbbbbbbbbbbbb0bbbbbbbbbbbbbbbbbbbbbbbbbb000000000055cc55000bbbbbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbbbbbbb
b0005500000000000000bbbbbbbbbbbbbbbbbbb00bbbbbbbbbbbbbbbbbbbbbbbb0000000000005cccc50000bbbbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbbbbbbb
0555555550055000000000000bbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbbbbbbb0000000000000000000550000000b0000000bbbbbbbbbbbbb00bbbbbbbbbbbbb
55cccccc5555000000000555000bbbbbbbb00000bbbbbbbbbbbbbbbbbbbbbbbb00000000000000000000555550000000000bbbbbbbbbbbb000bbbbbbbbbbbbbb
ccccc555550000000000555550000bbb0000000bbb7bbbbbbbbbbbbbbbbbbbbb000000055555555555000055555505550bbbbbbbbbbbbb000bbbbbbbbbbbbbbb
cccc5005555500000000005c50000000000000bbbbbbbbbbbbbbbbbbbbbbbbbb000555555555555555550000555555000bbbbbbbbbbb000bbbbbbbbbbbbbbbbb
ccc5555cccc55500000000555000000000000bbbbbbbb000000bbbbbbbbbbbbb5555555555cccc55555555000000000000000000000000bbb00000bbbbbbbbbb
cc55ccccccccc550000005555555555555000bbbbbbb00000000bbbbbbbbbbbb55555555cccccccccc55555500000555550000005000bbb00000000bbbbbbbbb
cc55ccccccccc55550000005555ccc555000bbbbbbb0000bb0000bbbbbbbbbbb5555555cccccccccccc55555505555ccc5500005000bbb00000b0000bbbbbbbb
c55cccccc555ccc550000555cccc55500000bbbbbb0050bbbbb00bbbbbbbbbbbc555ccccccccccccccccc5555555ccccccc5555000bbb00550bbbb00bbbbbbbb
cccccccc555055c5500555ccccc55000000bbbbb0005000bbbb00bbbbbbbbbbbc555ccccccccccccccccc555ccccc555555555000bb00050000bbb00bbbbbbbb
ccccccc5550005c550555ccccc550000000b0000005550000bb00bbbbbbbbbbbccccccccccccccccccccc5cccccc555500555550000005555000bb00bbbbbbbb
cccccccc550005c5555ccccc555500000000000555555500000000bbbbbbbbbbcccccccccccccccccccccccccccc55500005555000555555550000000bbbbbbb
cccccccc5555555555ccccc5555500000000055555cc555555000bbbbbbbbbbbcccccccccccccccccccccccccc5555000005cc5055555cc555555000bbbbbbbb
cccccccccccc55ccccccccc55c55500005555555ccc5500000000bbbbbbbbbbbcccccccccccccccccccccccccccc55500055cc55555ccc5550000000bbbbbbbb
cccccccccccccccccccccccccc555555555555ccccc5000bbbb000bbbbbbbbbbcccccccccccccccccccccccccccc5555555ccc555ccccc50000bbb000bbbbbbb
ccccccccccccccccccccccccccc555cc555ccccccc5500bbbbb0000bbbbbbbbbccccccccccccccccccccccccccccc555ccccccccccccc55000bbbb0000bbbbbb
cccccccccccccccccccccccccccccccccccccccccc5500bbbbbb0000bbbbbbbbccccccccccccccccccccccccccccccccccccccccccccc55000bbbbb00000bbbb
__map__
000000000000000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000d0d0d0d00000000000000000000000000000000000e0e000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001e0000001e000000000000000d000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000001e00000000001e0000000000000d000d0d00000e0000000000000000000000000e00000e000000000000000000000000000000000000000e000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001e001e00000000000000000d000d0000000e0000000000000000000000000e00000e00000000000000000000000000000000000000000e000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001e001e00000000000000000d000d000000000e000000000000000000000e00000000000000000000000000000000000000000000000e0e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000d00000000000d00000000000e000000000000000000000000000e0000000000000000000000000000000000000e000000000000000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001e0020001e000000000000000d0d0d0000000000000e00000000000e0e00000000000e000000000000000000000000000e0e00000e0e0e0e000000000000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001e1e1e00000000000000000000000000000000000000000e000e000000000000000e000000000000000000000e00000000000e0000000000000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0d00000d0d0d0d0d0d0d0d000000000000000000000000000000000e0e00000000000000000e00000000000000000e0e000000000e000000000000000000000e000e00000e0e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000e00000e0000000000000e00000000000e0e00000000000e0000000000000000000000000000000e000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000e000e0e0e0e000000000e0e0e0e0e000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000001f1f1f001f001f1f1f1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
