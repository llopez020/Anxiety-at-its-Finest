pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
-- init - called on run`
function _init()
cls()

mode = "menu" -- sets mode to debug menu
sound_enabled = true

#include collision.lua
#include animation.lua

function resetmode()
#include delete.lua
#include building_generator.lua

objlist=nil

--debug switch
debugint=0 -- shows collision boxes and coords
debugprint=0 -- shows object list

--animation test vars
start_animate = 1
sprite_animation = {24,25}
run_animation = {3,4,5,6}
run_animation2 = {3,4,5,6}
jump_animation = {8}
anxiety_animation = {64,72,128,136,128,72}
anxiety_animation2 = {64,72,128,136,128,72}
anxiety_animation3 = {64,72,128,136,128,72}
anxiety_animation4 = {64,72,128,136,128,72}
anxiety_animation5 = {64,72,128,136,128,72}
anxiety_animation6 = {64,72,128,136,128,72}
anxiety_animation7 = {64,72,128,136,128,72}
anxiety_animation8 = {64,72,128,136,128,72}
anxiety_animation9 = {64,72,128,136,128,72}
anxiety_animation10 = {64,72,128,136,128,72}
anxiety_animation11 = {64,72,128,136,128,72}
anxiety_animation12 = {64,72,128,136,128,72}
blob_animation = {247,248,249,250,251,252}
bounce = 0
--
a={}

-- Jumping Mechanics
onground = true
jumping = false
falling = false
y_jump  = 120
vy = 0
ay = 0
spd=0.5 -- movement speed
vel = spd*2 -- Edit this for natural falling speed 
button=-1

max_height = -20            -- height
gravity = 0.15              -- grav
initial_acceleration = -0.5*4 -- acc
alpha = 0.06				-- alpha     

---anexity bar init
negative_counter = 0
positive_counter = 0
bar_flag  = false
good_counter = 0
bad_counter = 0 
counting_flag = false
anexity_level = 0 
anexity_mult = 0.01 
anex_bar_color = 11
level_anex_bar_color = 11

anexitytimer=0
antianexitytimer=0
anexityshield=false
icontimer=0
icon=0
--- anexity
scrollspd=.02
--begin tinker
delta_t = 1.0/60.0
delta_x = 0
delta_y = 0
velocity_x=0.0
velocity_y=0.0
player_speed = 500.0
gravity_strength = 200.0
friction_strength = 10.0
jump_strength = 5000.0
deathtext=0
-- stop tinker

-- end


-- Menu selection 

menu_seleciton = "start"
ball_y = 92

-- end
--Setting selection

sound_selection = "on"
difficulty_selection = "easy"
s_bally = 52
setting_selection = "sound"
stepbystepflag = false
-- end 




mapwidth=128 -- map width
mapheight=30 -- map height

player = create_object("player",0,70,50,4,7) -- creates player object with sprite 0
loadmap() -- converts pico-8 map into objects

mapx=0 -- map x pos
mapy=0 -- map y pos
realmapx=mapx
realmapy=mapy
oldmapx=mapx -- map pos in previous frame
oldmapy=mapy -- map pos in previous frame
olddmapx=mapx
olddmapy=mapy

palt(6, true) -- green color as transparency is true
palt(0, false) -- black color as transparency is false

--Jumping Mecahinc
jump_height = 0
y_force = 0
jump_allowed = true

last = 0
textindex=0

game_over_flag = false
anxiety_difference = 0
music_init = false
music_choice = 0
music_speed = 28 -- can be hardcoded for this project
prev_elapsed = 0 -- ticks elapsed in current note
cutscene_timer = 0
cutscene_player_x = 10
cutscene_run = {3,4,5,6}

end
resetmode()
end
-->8
-- update - called on every frame
function _update60()

if mode=="initdebug" then initdebug() end -- debug menu
if mode=="test" then testmode() end -- game test
if mode=="test2" then testmode2() end -- anim test
if mode=="test3" then testmode3() end -- Gravity with landing particles 
if mode=="text" then textmode() end -- text box test 
if mode == "test4" then test4() end
if mode == "gameover" then gameover() end
if mode== "win" then win() end
if mode== "start" then start() end
if mode == "menu" then menu() end
if mode == "settings" then settings() end 

end


function p2(s,x,y,c) -- 26 tokens, 6.2667 seconds
for i in all(split'\f0\-f,\-h,\|f,\|h') do
	?i..s,x,y
end
	?s,x,y,c
end
--Menu method 
--needs background and color 
function menu()
	cls(12) -- blue background
	
	-- NEEDS A BACKGROUND DESSIGN 
	map(0,16)
	spr(199,8,80) -- remove the small cloud
	-- END 
	
	
	p2("start", 50 , 90 , 14)
	--print ("start" , 50 , 90,0)
	p2("settings", 50 , 100 , 14)
	--print ("settings" , 50 , 100,0)
	--print(stepbystepflag) -- Debug 
	
	circfill (45 , ball_y , 2 , 8)
	
	if btn(3) and stepbystepflag == false then 
	
		if menu_seleciton == "start" then
	
			menu_seleciton = "settings"
	
			ball_y = ball_y + 10
	
			stepbystepflag = true
	
	
		end
	end 
	
	if btn(2) and stepbystepflag == false then
	
		if menu_seleciton == "settings" then
			menu_seleciton = "start"
			ball_y = ball_y - 10
	
			stepbystepflag = true
		end
	
	end 
	
	if btn(5) and stepbystepflag == false then 
	
	if menu_seleciton == "start" then  
		mode = "start"
		stepbystepflag = true
	end
	
	if menu_seleciton == "settings" then
		mode ="settings"
		stepbystepflag = true
	end 
	
	end -- end button x
	
	if not btn(2)  and  not btn(3) and not btn(5) then
	
		stepbystepflag = false
		
	end 
	
	end -- end menu
	
	function settings ()
	
	
	cls(12) -- blue background
	map(0,16)	
	spr(199,8,80) -- remove the small cloud
	p2("sound", 30 , 50 , 14)
	--print ("sound" , 30 , 50 , 0)
	p2(sound_selection, 70 , 50 , soundcolor(sound_selection))
	--print (sound_selection , 80 , 50,0)
	p2("dificulty", 30 , 60 , 14)
	--print("dificulty" , 30 ,60,0)
	p2(difficulty_selection, 70 , 60 , dangercolor(difficulty_selection))
	--print(difficulty_selection , 70 , 60,0 )
	p2("back", 30 , 80 , 14)
	--print("back", 30 , 80,0)
	
	circfill(25 , s_bally , 2, 8 )
	
	if btn(3) then
	
		if setting_selection == "sound" and stepbystepflag == false then 
	
		s_bally = s_bally + 10 
		setting_selection = "difficulty"
		stepbystepflag = true
		end
	
		if setting_selection == "difficulty" and stepbystepflag == false then
		s_bally = s_bally + 20
		setting_selection = "back"
		stepbystepflag = true
		end
	
	end
	
	if btn (2) then 
	
		if setting_selection == "back" and stepbystepflag == false then
	
			s_bally = s_bally - 20 
			setting_selection = "difficulty"
			stepbystepflag = true
		end
		if setting_selection == "difficulty" and stepbystepflag == false then
			s_bally = s_bally - 10 
			setting_selection = "sound"
			stepbystepflag = true
		end
	
	end 
	
	if btn(5) then 
	
		if setting_selection == "sound" and stepbystepflag== false then
	
			if sound_selection == "on" then 
				sound_enabled = false
				sound_selection = "off"
				stepbystepflag = true
			else
				sound_enabled = true
				sound_selection = "on"
				stepbystepflag = true
			end
		end
	
	
		if setting_selection == "difficulty" and stepbystepflag == false then
	
			if difficulty_selection == "easy" then
				difficulty_selection = "medium"
				stepbystepflag = true
			elseif difficulty_selection =="medium" then
				difficulty_selection = "hard"
				stepbystepflag = true 
			else 
				difficulty_selection = "easy"
				stepbystepflag = true
			end
	
		end 
	
		if setting_selection == "back" and stepbystepflag == false then
			mode = "menu"
			stepbystepflag = true 
		end
	
	end
	
	--ensures that one movement at one time 
	if not btn(2) and not btn(3) and not btn(5) then
	
	stepbystepflag = false
	
	end 
	
	end 
	-- end settings 

function dangercolor(diflev)

if diflev == "easy" then

return 11
end

if diflev == "medium"then 
return 9
end 

if diflev =="hard" then
return 8
end
end

function soundcolor(soundval)

if soundval == "on" then 

	return 11
end

if soundval == "off" then

	return 8
end

end


function start()
 	cls(12)
 	if cutscene_timer==0 then animate_once(7,62,{17,18,19,20},1,1,26,2) end
 	if cutscene_timer==100 then animate_once(7,62+5,{21,22},1,1,5,2) end

	map(0,18)
	
	if cutscene_timer>=105 then animate(cutscene_run,cutscene_player_x,75,cutscene_run,1,1,15) cutscene_player_x += 1 else spr(8,10,73) end

	textbox(0,90,127,127,"the anxiety is building up...\nget ready!")
 	cutscene_timer += 1
	handle_animations()
 	if textindex>100 then mode="test" textindex=0 resetmode() end
end

function gameover()
 
 if(game_over_flag == false) then if(sound_enabled) then sfx(18) music(5) end game_over_flag = true end
 if textindex==0 then gmt=flr(rnd(8)) end
 rectfill(0,0 , 128,128,0)
 
 if gmt==0 then textbox(0,90,127,127,"game over!\npress ❎ to play again!\nkeep breathing, it will be\nokay!") end
 if gmt==1 then textbox(0,90,127,127,"game over!\npress ❎ to play again!\nnever give up! things are \nnever as bad as they seem!") end
 if gmt==2 then textbox(0,90,127,127,"game over!\npress ❎ to play again!\nfeeling stressed? speak to a\nfriend!") end
 if gmt==3 then textbox(0,90,127,127,"game over!\npress ❎ to play again!\nif things are becoming too\noverwhelming, take a break!") end
 if gmt==4 then textbox(0,90,127,127,"game over!\npress ❎ to play again!\nremember that you are always\nloved!") end
 if gmt==5 then textbox(0,90,127,127,"game over!\npress ❎ to play again!\nsometimes, it can be helpful\nto take a step back and gain \nsome clarity on the situation!") end

 if gmt>5 then textbox(0,90,127,127,"game over!\npress ❎ to play again!") end
 if btn(❎) and textindex>30 then mode="test" resetmode() end
 
end

function win()
 
 textbox(0,90,127,127,"you win!\npress ❎ to restart")
 if btn(❎) and textindex>30 then mode="test" resetmode() end
 
end
-->8
-- test - test mode
function testmode()

cls(12)
handle_music()
create_buildings()
cull_buildings()
renderBuildings()

handle_animations()

if (realmapx>1) then realmapx=0 end
if (realmapy>1) then realmapy=0 end

map(0, 0, realmapx, realmapy, 128, 32)
drawallobj() -- draws objects on to screen

animate(anxiety_animation,sin(bounce)*4-40,96-8,anxiety_animation,8,4,5)
animate(anxiety_animation2,sin(bounce)*4-40,110-8,anxiety_animation2,8,4,11)
animate(anxiety_animation3,sin(bounce)*4-40,120-8,anxiety_animation3,8,4,17)
animate(anxiety_animation4,sin(bounce)*4-40,96-35,anxiety_animation4,8,4,5)
animate(anxiety_animation5,sin(bounce)*4-40,110-35,anxiety_animation5,8,4,11)
animate(anxiety_animation6,sin(bounce)*4-40,100-35,anxiety_animation6,8,4,17)

animate(anxiety_animation7,sin(bounce)*4-40,96-8-63,anxiety_animation7,8,4,5)
animate(anxiety_animation8,sin(bounce)*4-40,105-8-63,anxiety_animation8,8,4,11)
animate(anxiety_animation9,sin(bounce)*4-40,115-8-63,anxiety_animation9,8,4,17)
animate(anxiety_animation10,sin(bounce)*4-40,96-35-63,anxiety_animation10,8,4,5)
animate(anxiety_animation11,sin(bounce)*4-40,105-35-63,anxiety_animation11,8,4,11)
animate(anxiety_animation12,sin(bounce)*4-40,17-35-63,anxiety_animation12,8,4,17)

----- anexity bar code
if anexitytimer<=0 and antianexitytimer<=0 then 
 local anxmax = 150
 rectfill(player.x-(anxmax-anexity_level),0 , player.x-(anxmax-anexity_level)-128,128,0)
 rectfill(0,player.y-(anxmax-anexity_level),128 ,player.x-(anxmax-anexity_level)-128,0)
 rectfill(player.x+(anxmax-anexity_level),0 , player.x+(anxmax-anexity_level)+128,128,0)
 rectfill(0,player.y+(anxmax-anexity_level),128 ,player.x+(anxmax-anexity_level)+128,0)

 for i=0,flr((anxmax-anexity_level)/5)+15 do 
  circ(player.x,player.y,(anxmax-anexity_level)+i,0)
//  circ(player.x-1,player.y,(anxmax-anexity_level)+i,0)
 end
elseif anexitytimer>0 then
 local anxmax = 150
 local anexity_levelg= 130
 rectfill(player.x-(anxmax-anexity_levelg),0 , player.x-(anxmax-anexity_levelg)-128,128,0)
 rectfill(0,player.y-(anxmax-anexity_levelg),128 ,player.x-(anxmax-anexity_levelg)-128,0)
 rectfill(player.x+(anxmax-anexity_levelg),0 , player.x+(anxmax-anexity_levelg)+128,128,0)
 rectfill(0,player.y+(anxmax-anexity_levelg),128 ,player.x+(anxmax-anexity_levelg)+128,0)

 for i=0,flr((anxmax-anexity_levelg)/5)+15 do 
  circ(player.x,player.y,(anxmax-anexity_levelg)+i,0)
 end 
elseif antianexitytimer>0 then	

end
 
if anexitytimer>0 then anexitytimer=anexitytimer-1 icontimer=1 icon=43 end
if antianexitytimer>0 then antianexitytimer=antianexitytimer-1 icontimer=1 icon=38 end
if anexityshield==true then spr(228,52,120) end
 
local movement_bar = 243
local empty_bar = 242
local left_bar = 240
local right_bar = 245
--this will change how much time will take to the anex to pasive increase
local passive_time_anexity_increse = 0.5
-- how much anex will increase pasive
local passive_increase_level = 2
-- bar speed multiplier -note 2 is crazy fast
local bar_spd = .7 
-- how much points will increase your anex with a bad hit 
local bad_hit_amount = 8
--how much points will decrease your anex with a good hit
local good_hit_amount = 10

if anexity_level<=0 then anexity_level=0 end
if anexity_level>100 then wait(3) mode="gameover" end
spr(left_bar, 0+60 ,112) -- inital bar
spr(empty_bar, 8+60 ,112) -- empty bar
spr(empty_bar, 16+60 ,112) -- empty bar 
spr(empty_bar, 24+60 ,112) -- empty bar
spr(right_bar, 32+60 ,112) -- end bar 

--anexity level bar

level_draw = 36 * anexity_level / 100

rect(0+60, 122 , 39+60 , 126 , 5)
rectfill(1+60,123,60+2 + level_draw,125,level_anex_bar_color)

	--filling reclangle color change 

	if anexity_level < 25 then
		level_anex_bar_color = 11
	elseif anexity_level < 50 then
		level_anex_bar_color = 10
	elseif anexity_level < 75 then
		level_anex_bar_color = 9
	else 
		level_anex_bar_color = 8
	end 


	---end rectangle color change 

	--important for time increase
 	gentime = time()-last
	--debbuging pritning
//	print(gentime)
	//print(good_counter)
	//print(bad_counter)
	//print(anexity_level)
	--end debugging 

	--passive increase code
	if gentime> passive_time_anexity_increse or gentime == time() then last = time() end
	--end this


	if gentime == passive_time_anexity_increse and anexity_level < 100 then 

		anexity_level = anexity_level + passive_increase_level

	end
	-- end passive increase code 

	--bar movement code 
	if positive_counter < 32  and bar_flag == false then
	positive_counter = positive_counter + 1 * bar_spd
	else
		bar_flag = true
	//	print(positive_counter)
		positive_counter = positive_counter - 1 * bar_spd

		if positive_counter == 0 then
			bar_flag = false
		end

	end
	--end bar movement code 

	--code change the color of the bar when correct area
	if (positive_counter >= 0 and positive_counter <= 8 ) or ( positive_counter >= 24 and positive_counter <=32 )then
		anex_bar_color = 11
	else
		anex_bar_color = 8
	end
	-- end code change the color of the bar in the correct area
function correct_hit()

		--print("good") --debug code
		--decrease level anexity  code 
		if counting_flag == false then
		good_counter = good_counter+1

		if anexity_level > 0 then

			anexity_level = anexity_level - good_hit_amount
		end
		
		icon=221 icontimer=20
		counting_flag = true
		end

		--end funcionality for decrease level

				rectfill(0,0,128,0,11)
				rectfill(0,127,128,128,11)
				rectfill(0,0,0,128,11)
				rectfill(127,0,127,128,11)

		--put here your code for any other reacitons when correct hit 

		-- end put here code 

	end 

	function bad_hit()


		--print("bad") -- debug 

		--increase level of anexity code 
		if counting_flag == false then
		bad_counter = bad_counter + 1

		if anexity_level < 100 then

			anexity_level = anexity_level + bad_hit_amount

		end
		
		icon=222 icontimer=20
		counting_flag = true
		end
		-- end increase level of anexity code 


 			rectfill(0,0,128,0,8)
				rectfill(0,127,128,128,8)
				rectfill(0,0,0,128,8)
				rectfill(127,0,127,128,8)

		--put here your code for any other reactions when correct hit 


		-- end put here code 

	end

	--if anexity gets into 100 code
	if anexity_level >= 100 then

		-- here goes code for death or any other consequences  


	end
	
	--button press handeler
	if btn(5) then
		if (positive_counter >= 0 and positive_counter <= 8 ) or ( positive_counter >= 24 and positive_counter <=32 )then
			correct_hit()
		else
			bad_hit()

		end

	else

	counting_flag = false

	end
	-- end button press handeler

	--functions for correct and bad hit 
	-- end anexity level code 

	--anexity bar moving arround code 
	rectfill(60+1+positive_counter,116,60+6+positive_counter,118,anex_bar_color) -- anexity bar moving 
	--end anexity bar moving arround code 

--- end anexityy bar code 

button=-1
-- fps debug

ai()
-- sets initial pos, should not be changed
player.oldx=player.x player.oldy=player.y olddmapx=mapx olddmapy=mapy

-- print object list
if debugprint==1 then printlist() end

--begin movement code
velocity_y += gravity_strength*delta_t
velocity_x -= velocity_x*friction_strength*delta_t

if btn(1) then velocity_x += player_speed*delta_t+(anexity_level*anexity_mult) player.dir=1 end
if btn(0) then velocity_x -= player_speed*delta_t+(anexity_level*anexity_mult) player.dir=2 end
if btn(4) and onground==true then velocity_y -= jump_strength*delta_t if(sound_enabled) then sfx(16) end end
player.x=player.x+(velocity_x*delta_t) //mapx+=.125*(velocity_x*delta_t)
if(checkallcol(player,0)) then
	velocity_x = 0
end

if(player.x > 123) then
	velocity_x = 0
end

//print(onground)
//print(velocity_x)
//print(velocity_y)

player.y=player.y+(velocity_y*delta_t) mapy+=.125*(velocity_y*delta_t)
if(checkallcol(player,1)) then
	if(velocity_y > 0) then
		onground = true
		velocity_y=0
	else
		onground = false
		if(player.dir == 1) then
			animate(jump_animation,player.x+1,player.y,jump_animation,1,1,10,false)
		else
			animate(jump_animation,player.x-4,player.y,jump_animation,1,1,10,true)
		end
		button=1 --janky
	end
	velocity_y = 0	
else
	onground = false
	if(player.dir == 1) then
		animate(jump_animation,player.x+1,player.y,jump_animation,1,1,10,false)
	else
		animate(jump_animation,player.x-5,player.y,jump_animation,1,1,10,true)
	end
	button=1 --janky
end

if btn(1) and onground==true then animate(run_animation,player.x-2,player.y+1,run_animation2,1,1,10,false) button=1 end
if btn(0) and onground==true then animate(run_animation,player.x-3,player.y+1,run_animation2,1,1,10,true) button=0 end

-- moves map if player is in middle of screen	
//if player.x>64 and mapx<mapwidth-8 then player.x=64 end
--if player.x<64 and mapx>=0+8 then player.x=64 end --no scroll back
if player.y>64 and mapy<mapheight-7.875 then player.y=64 end
if player.y<64 and mapy>=0+8 then player.y=64 end

//if mapy>mapheight then mapy=mapheight end
//if mapy<0 then mapy=0 end 

-- moves all objects to correct map position
//if player.x==64 and player.x==player.oldx and player.x!=0 then moveallx() building_data.xoffset_camera+=((olddmapx-mapx)*8) end
if mapx>=mapwidth-16 then 
	building_data = { --loop map
		buildings_end = 0,
		xoffset_build = 0,
		yoffset_build = 63,
		xoffset_camera = 0,
		yoffset_camera = 63
	}
	translate_buildings(flr(mapx*8))
	mapx=0 -- map x pos
	mapy=0 -- map y pos
	realmapx=mapx
	realmapy=mapy
	oldmapx=mapx -- map pos in previous frame
	oldmapy=mapy -- map pos in previous frame
	olddmapx=mapx
	olddmapy=mapy
end

mapx=mapx+scrollspd+((anexity_level*anexity_mult)/8)
player.x=player.x-((scrollspd*8)+(anexity_level*anexity_mult))
checkallcol(player,0)
moveallx() building_data.xoffset_camera+=((olddmapx-mapx)*8) 
if player.y==64 and player.y==player.oldy and player.y!=0 then moveally() building_data.yoffset_camera+=((olddmapy-mapy)*8) end

if player.x<6 then wait(3) mode="gameover" end

//if mapy<8 then mapy=8 end
-- prints map pos
//print(mapx.." "..ceil(player.x),40,0,7)
//print(mapy.." "..ceil(player.y),40,9,7)
if(bounce > 1) then
	bounce = 0
else
	bounce = bounce + 0.010
end

if icontimer>0 then icontimer=icontimer-1 spr(icon,100,120) end

if debugint==1 then print(stat(7).." fps\n",0,0,7) end
//circ(64,64,150-anexity_level,0)

end


function ai()
 	local temp = objlist
		while temp do
		
		 -- call cat ai (can be used as template)
			if (temp.value.id=="cat") then catai(temp.value) end

			if (temp.value.id=="blob") and temp.value.sprite>=254 then blobai(temp.value) end
			if (temp.value.id=="item") then itemai(temp.value) end

			if (temp.value.id=="explosion") then explosionai(temp.value) end

			temp = temp.next
		end
end

function catai(obj) 

	-- pick a walking direction periodically
	if flr(rnd(100))==1 then obj.dir=flr(rnd(3)) end

 -- move in said direction
	if obj.dir==0 then obj.x=obj.x+spd checkallcol(obj,0) end
	if obj.dir==1 then obj.x=obj.x-spd checkallcol(obj,0) end
//	if obj.dir==2 then obj.y=obj.y-spd checkallcol(obj,1) end
	//if obj.dir==3 then obj.y=obj.y+spd checkallcol(obj,1) end

end

function blobai(obj) 
 -- move in said direction
	obj.vel=obj.vel+0.01
	obj.y=obj.inity-6+((sin(obj.vel)*7))+realmapy
	
end

function itemai(obj) 
 -- move in said direction
	obj.vel=obj.vel+0.005
	obj.y=obj.inity-6+((sin(obj.vel)*4))+realmapy
	
end

function explosionai(obj) 
 -- move in said direction
	obj.floor+=3
	circ(obj.x,obj.y, obj.floor,8)
	if obj.floor>100 then deleteobj(obj) end
end

function item_handling(item)
 --fire
if item.sprite==14 then create_object("explosion",255,item.x,item.y,0,0) deleteallof("blob", player.x) if(sound_enabled) then sfx(23) end end
 
 if item.sprite==16 then anexityshield=true end
 --cloud
 if item.sprite==44 then anexity_level-=30 icon=221 icontimer=40 end
 --spiral
 if item.sprite==40 then if anexityshield==false then anexitytimer=300 antianexitytimer=0 else anexityshield=false end end
 --blue heart
 if item.sprite==15 then antianexitytimer=300 anexitytimer=0 end
end

-- moves all objects in the x direction if not player
function moveallx()
 	local temp = objlist
		while temp do
			if (player.id!=temp.value.id) then temp.value.x=temp.value.x+((olddmapx-mapx)*8)
			 temp.value.oldx=temp.value.x
			end
			temp = temp.next
		end
  realmapx = realmapx+((olddmapx-mapx)*8)		
end


-- moves all objects in the y direction if not player
function moveally()
 	local temp = objlist
		while temp do
			if (player.id!=temp.value.id) then temp.value.y=temp.value.y+((olddmapy-mapy)*8)
			 temp.value.oldy=temp.value.y			
			end
			temp = temp.next
		end
  realmapy = realmapy+((olddmapy-mapy)*8)
end


-- draws all nearby objects
function drawallobj()
 	local temp = objlist
		while temp do
			if temp.value.x>0-8 and temp.value.x<128-8+8 and temp.value.y>0-8 and temp.value.x<128-8+32 then 
				if temp.value.id=="blob" and temp.value.sprite<254 then  
				 temp.value.sprite=temp.value.sprite+.12
					animate(blob_animation,temp.value.x,temp.value.y,blob_animation,1,1,20,false)				
				else
				 temp.value.draw(temp.value) 
				end
			end
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
		 if temp.value.id=="bg" or temp.value.id=="null" or temp.value.id=="explosion" then goto continue end
		 if (abs(obj1.x-temp.value.x)>obj1.width*4 or abs(obj1.y-temp.value.y)>obj1.height*4) then goto continue end
			
			-- if object is not the object being checked, check for collision
			if (obj1!=temp.value and temp.value.id=="plat" and flr(obj1.y)+1>=flr(temp.value.y)-6 and velocity_y<0) then goto continue end
 		if (temp.value.id=="item" or temp.value.id=="blob") then if checkcol(obj1, temp.value,x_y)==true then if(sound_enabled) then if (temp.value.id=="item") then sfx(17) else sfx(22) end end temp.value.sprite=255 temp.value.id="null" end goto continue end			
			if (obj1!=temp.value and temp.value.id!="bg" and checkcol(obj1, temp.value,x_y)==true) then if x_y==1 then obj1.floor=1 end return true end
			::continue::
			temp = temp.next
		end

  if (checkcoltile(obj1, x_y)==true)	then	if x_y==1 then obj1.floor=1 end return true end

		-- if object is not the player, update oldx and oldy depending on x_y
		if obj1.id!="player" then obj1.oldx=obj1.x obj1.oldy=obj1.y end

		if x_y==1 then obj1.floor=0 end
		
  -- if object is player, update olddmap
		if obj1.id=="player" then oldmapx=mapx oldmapy=mapy end 

		-- no collision occurred
		return false
end

-- checks for collision between two objects
function checkcol(obj1, obj2,x_y)
 bool = sprcoll(obj1.x,obj1.y,obj1.width,obj1.height,obj2.x,obj2.y,obj2.width,obj2.height)
 if bool==true and obj2.id=="item" then item_handling(obj2) rectfill(0,0,128,0,11)	rectfill(0,127,128,128,11)	rectfill(0,0,0,128,11)	rectfill(127,0,127,128,11) return bool end
 if bool==true and obj2.id=="blob" then if anexityshield==false then anexity_level+=25 rectfill(0,0,128,0,8)	rectfill(0,127,128,128,8)	rectfill(0,0,0,128,8)	rectfill(127,0,127,128,8) icon=222 icontimer=20 return bool else anexityshield=false return bool end end
 -- if collision occurs, send back to old pos based on x_y, else return false
	if bool==true then if x_y==0 then obj1.x=obj1.oldx else obj1.y=obj1.oldy end
			if obj1.id=="player" then mapy=oldmapy end 
			if obj1.id=="player" and obj2.id=="sign" then  textbox(0,90,127,127,"secret text!!") end
	end 
	
	return bool
end
 
function checkcoltile(obj1, x_y)
 bool = tilecoll(obj1.x,obj1.y,obj1.width,obj1.height)
 
 -- if collision occurs, send back to old pos based on x_y, else return false
	if bool==true then if x_y==0 then obj1.x=obj1.oldx else obj1.y=obj1.oldy end
			if obj1.id=="player" then mapx=oldmapx mapy=oldmapy end 
	end 
	
	return bool
end


function handle_music()
	if(not sound_enabled) then return end
	tick = stat(26)
      elapsed = tick % music_speed
      if elapsed < prev_elapsed then
        -- new beat has begun
        beats = flr(tick / music_speed)
        if (beats % 32 == 0) then
			if(abs(anxiety_difference-anexity_level)>=20) then
				music_choice = flr((anexity_level/20))
				music(music_choice)
				anxiety_difference = anexity_level
			end
		end
      end
      prev_elapsed = elapsed
	if(music_init == false) then music(0) music_init = true end
end

function testmode2()

cls(14)

print"hello, this is a test mode."
--begin showcase
if(start_animate == 1) then
	animate_once(30,30,{0,1,2},1,1,30,2)
	animate_once(30+8,30,{3,4,5},1,1,15,3)
	animate_once(30+8+8,30,{6,7,8},1,1,15,2)
	animate_once(30+8+8+8,30,{6,7},1,1,10,2)
	start_animate = 0
end
print("these animations are called once",0,30+8)
print("animations currently playing: "..#animation_data_once,0,30+8+8)
if(#animation_data_once == 0) then
	start_animate = 1
end

animate(sprite_animation,30,30+8+8+8,sprite_animation,1,1,10)
animate(run_animation,30+8+8,30+8+8+8,run_animation,1,1,10)
--animate(anxiety_animation,sin(bounce)*4-4,96,anxiety_animation,8,4,5)
--animate(anxiety_animation2,sin(bounce)*4-4,105,anxiety_animation2,8,4,11)
--animate(anxiety_animation3,sin(bounce)*4-4,115,anxiety_animation3,8,4,17)
if(bounce > 1) then
	bounce = 0
else
	bounce = bounce + 0.010
end
print("this animation is continuous",0,30+8+8+8+8)

handle_animations()
renderBuildings()
print("# of floors: "..building_list[#building_list].number_of_floors,44,30+8+8+8+8+8,0)
print("elements per floor: "..building_list[#building_list].elements_per_floor,0)
print("door slot: "..building_list[#building_list].door_slot,0)
--end showcase
end

function initdebug()

cls()

print"press 🅾️ for mode 1,\npress ❎ for mode 2, \npress ⬇️ for mode 3,\npress ⬆️ for mode 4 \n press left arrow for mode 5"

if btn(4) then mode = "test" end
if btn(5) then mode = "test2" end
if btn(3) then mode = "test3" end -- Mode 3 for testing 
if btn(2) then mode = "text" end
if btn(0) then mode = "test4" end

end

function loadmap()
	for i=0,mapwidth,1 do
		for j=0,mapheight,1 do
		 if (mget(i,j)!=0) then 
		 		if (mget(i,j)==35) then -- cat
		 		 create_object("cat",mget(i,j),i*8,j*8+3,6,5) 
		 		 mset(i,j,0)
					end
					if (mget(i,j)==59) then -- cat
					//	create_object("sign",mget(i,j),i*8,j*8,8,8) 
		 		 //mset(i,j,0)
					end
					if (mget(i,j)==247) then -- cat
						create_object("blob",247,i*8,j*8,8,7) 
		 		 mset(i,j,0)
					end
					if (mget(i,j)==52) then -- cat
						create_object("plat",52,i*8,j*8,8,2) 
		 		 mset(i,j,0)
					end
		 	end
	 	end
	 end
	for i=0,mapwidth,1 do
		for j=0,mapheight,1 do
		 if (mget(i,j)!=0) then 
		 		if (mget(i,j)==35 or mget(i,j)==247) then -- cat
		 		 --skip
		 		else if (mget(i,j)!=55) and (mget(i,j)!=56) and (mget(i,j)!=57) and (mget(i,j)!=58) and (mget(i,j)!=59) and (mget(i,j)!=61) and (mget(i,j)!=46) and (mget(i,j)!=62) and (mget(i,j)!=30) and (mget(i,j)!=204) and (mget(i,j)!=246) then -- wall
		 	//		create_object("wall",mget(i,j),i*8,j*8,8,8) 
		 		else -- background 
	//	 			create_object("bg",mget(i,j),i*8,j*8,8,8) 
		 		end
		 	end
	 	end
	 end
	end
	
	for i=0,mapwidth,2 do
	 --create_object("wall",255,i*8,-8,8*3,8)
	 --create_object("wall",255,i*8,(mapheight)*8,8*3,8)
	end
	
	for i=0,mapheight,3 do
	 --create_object("wall",255,-8,i*8,8,8*3)
	 --create_object("wall",255,(mapwidth)*8,i*8,8,8*3)
	end
end

function textmode()
 cls(12)
 drawallobj()
 textbox(0,90,127,127,"test test test test test test\ntest test test this is a test\nit works!!!!!")
end

function textbox(x1,y1,x2,y2,text)
 rectfill(x1,y1,x2,y2,0)
 rectfill(x1+1,y1+1,x2-1,y1+1,7)
 rectfill(x1+1,y1+1,x1+1,y2-1,7)
 rectfill(x1+1,y2-1,x2-1,y2-1,7)
 rectfill(x2-1,y1+1,x2-1,y2-1,7)
 print(sub(text,0,textindex),x1+4,y1+4,7)
 textindex+=.5
 if textindex>#text+5 and mode!="gameover" and mode!="win" and mode!="start" then textindex=0 end
 //wait(5)
end

function wait(a) for i = 1,a do flip() end end

-->8
-- Test mode 3 for objects 
function testmode3()

cls(12) --Clearing the screen

-- Charachter still animation falling down

vel = 1.25 -- Edit this for natural falling speed 


drawallobj() --This function draws all the items in the screen

if debugint==1 then print(stat(7).." fps\n",0,0,7) end

ai()
-- sets initial pos, should not be changed
player.oldx=player.x player.oldy=player.y olddmapx=mapx olddmapy=mapy

//spd=1
-- X cordinate movement
if btn(1) then player.x=player.x+spd checkallcol(player,0) mapx+=.125*spd end
if btn(0) then player.x=player.x-spd checkallcol(player,0) mapx-=.125*spd end
-- Y cordinate movement


--Code that makes the player jump and fall if not doing nothing 
if btn(4) and player.floor==1
then 
player.y=player.y-spd checkallcol(player,1) mapy-=.125*spd
ay = initial_acceleration
player.floor = 0
jumping = true
elseif btn(4) and jumping then
	player.y=player.y-spd checkallcol(player,1) mapy-=.125*spd
	ay += alpha
	if ay > gravity then
		ay = gravity
		jumping = false
	end
else 
	ay = gravity
	jumping = false
	player.y=player.y+spd checkallcol(player,1) mapy+=.125*spd
end 

vy += ay 
y_jump += vy-- i dont think this is in use !

---HELP I CANT NOT FIND A WAY TO DETECT IF THE PLAYER IS ON THE GROUND OR NOT

//if mget (player.x , player.y + 1) == true then
	//onground = true
	//vy = 0
//end


-- END OF JUMPING CODE





if btn(3) then player.y=player.y+spd checkallcol(player,1) mapy+=.125*spd end

end ---- END MODE 3  


-->8
-- Mode 4 anexity bar

function test4()
cls(12)

local movement_bar = 255
local empty_bar = 242
local left_bar = 240
local right_bar = 245
local seconds = 2 -- change this to change the speed of the bar 

spr(left_bar, 0 ,112) -- inital bar
spr(empty_bar, 8 ,112) -- empty bar
spr(empty_bar, 16 ,112) -- empty bar 
spr(empty_bar, 24 ,112) -- empty bar
spr(right_bar, 32 ,112) -- end bar 
 

 gentime = time()-last
	print(gentime)
	
	if gentime>9 or gentime == time() then last = time() end

	if gentime > 1 and gentime < 2 then
		spr(movement_bar, 8 , 112)
		if btn(5) then 
			bad_hit()
		end
	end 
	if gentime > 2  and gentime < 3 then
		spr(movement_bar, 16 , 112)
		if btn(5) then 
			bad_hit()
		end
	end 
	
	if gentime > 3 and gentime < 4 then
		spr(movement_bar, 24 , 112)
		if btn(5) then 
			bad_hit()
		end
	end 

	if gentime > 4 and gentime < 5 then
		spr(movement_bar, 32 , 112)
		if btn(5) then
			correct_hit()
		end
	end
	
	if gentime > 5  and gentime < 6 then
		spr(movement_bar, 24 , 112)
		if btn(5) then 
			bad_hit()
		end
	end

	if gentime > 6  and gentime < 7 then
		spr(movement_bar, 16 , 112)
		if btn(5) then 
			bad_hit()
		end
	end

	if gentime > 7  and gentime < 8 then
		spr(movement_bar, 8 , 112)
		if btn(5) then 
			bad_hit()
		end
	end

	if gentime > 8  and gentime < 9 then
		spr(movement_bar, 0 , 112)
		if btn(5) then
			correct_hit()
		end
	end
	


	function correct_hit()

		cls(3)
		print("Good")

	end 

	function bad_hit()

		cls(8)
		print("Bad")


	end


end



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
mapy, -- map y pos
dir=2,
vel=-0.1,
floor=0, -- landed or not
inity=ry
}

 -- draws obj
	function a.draw(obj)
	 if obj.id=="player" then if button==-1 then spr(obj.sprite,obj.x,obj.y+1,obj.width/8,obj.height/8) end
		else 
			spr(obj.sprite,obj.x,obj.y,obj.width/8,obj.height/8)
	 end
	end

addtolist(a)

return a
end

 
function addtolist(a)
 	objlist= {
 		next=objlist,
 		value=a
 	}
 	if debugprint==1 then print("added object"..a.sprite) end
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
14416666146666664066666666614666666146666661466666614666146666661466666666666666666666666c6666c66c6666c6444444446688666666611666
1ff166661f666666f06666666661f6666661f6666661f6666661f6661f6666661f66666666666666f44f6666c6c66c6cc6c66c6c4444444468866866611cc116
222266662266666622666666662226666622266666222666662226662266666622f66666666666662ff26666c6c00c6c66c00c66444444448986668661cccc16
22226666226666662266666666f22f6666f22f6666f22f6666f22f662266666622666666666666662222666666044066c604406c44444444898668981cc07cc1
f55f6666f56666665f66666666622666666226666662266666622666f5666666555666666666666662266666c622226c662222664444444489a888981cc00cc1
6556666665666666566666666256066666506666620656666605666655666666662666664f2256666556666666255266c625526c4444444489aaaa8661c00c16
6226666662666666266666666666266666226666666626666622666622666666666666661122f52662266666c6f00f6c66f00f6644444444689aa986611cc116
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666444444446689986666611666
68866886666666666666666666666666666666666a66a6666a66a666655666666556666655666666644666664466666644666666646696664444444466666666
8ee8877866661116666611166666111666661116aa666aaa66a66aaa6ff666665ff66666ff566666644666664466666644666666496664664442444466666666
8e0ee0e861161111611611116116111161161111a6666a666aa66a66000066665006666600566666000066660066666600666666444496664444444466666666
8eeeeee861111111611111116111111161111111aa66a66666a6a6a6700766666706666607666666700766667066666607666666649966662444442444424244
8e0ee0e81111111111111111111111111111111166a6a6666a6666a6f00f66666f0666660f666666400466664066666604666666646966664444444442444444
68e00e86666666666c66c66c66666666666666666a66a666a66666a6600666666606666606666666600666666066666606666666666666664424444444444424
668ee8666666666666666666c66c66c6666666666a666a6666a66a66600666666606666606666666600666666066666606666666666666664444444224242444
66688666666666666666666666666666c6c666c666a666aa6a666a66666666666666666666666666666666666666666666666666666666664442444424444442
666ccc66646666666066666660660666777777444477777766666666600000066dddddd600066666666cc66660000006666ccc6666666606bbbbb9bbbbbbbbbb
66c777c6496669660066666600666066777777444477777766cccc6604777740d222222d08066666666cc6660444444066c777c666666030b8bb9a9bbbbbbbbb
6c77777c99494666000006660000066677777744447777776c7777c607477470d2ddddd20806666666cccc660ffffff06c77777c66660330828bb9bbbbbbbbbb
6c777c7c6949666660006666600066667777774444777777c770777c07744770d2d222d20806666666cccc66000ff0006c777c7c00603306b8bbbbbb33333333
66c7c77c6969666660606666606066667777774444777777c770077c07744770d2ddd2d2080666666cccc7c60ccffcc066c7c77c33033066bbbbbb1b33333333
666c77c666666666666666666666666677777744447777776c7007c607477470d22222d200066666c7cccccc0cf88fc0666c77c603330666bbabb1a133344333
66c77cc6666666666666666666666666777777444477777766cccc6604777740ddddddd208066666cc77cccc6cf88fc666c77cc660306666ba4abb1b34344443
ccccc6666666666666666666666666667777774444777777666666666000000662222226000666666cccccc666ffff66ccccc66666066666bbabbbbb44444444
6886666688666666886666665777777799999999777777755555555575555557555555555555555544444444444444446664444666666666bbbbbbbbb8bbb8bb
644666664466666644666666577777776999999677777775555555557777777755555555555555558884888445555554664545a466666666bbbbbbbb828b8a8b
8888666688666666886666665777777766666666777777755555555555555555aaaaaaaa55555555444444444545445466454a5466644666bbbbbbbbb8bbb8bb
4884666648666666846666665777777766666666777777755555555555555555aaaaaaaa555555558488848845555554664545a466888866bbbbbbbb33333333
4114666641666666146666665777777766666666777777755555555555555555555555555555555544444444454454546645455468844886bbbbbbbb33333333
61166666616666661666666657777777666666667777777577777777555555555555555555555555888488844555555466454aa466844866bbbbbbbb43333343
6886666668666666866666665777777766666666777777755555555555555555555555555555555544444444455555546645455466888866bbbbbbbb43444344
6666666666666666666666665555555566666666555555557777755555555555555555555555555584888488444444446646444468888886bbbbbbbb44444444
66666666666600666000066666666666666666666666666666660000000000506666666666666666660000000666666666666666666666666666666666666666
66666666666600660666006666666666666666666666666666005500000000666666666666666666666666600500666666666666666666666666666000666666
66666666666600000666600666666666660000066666666660050006666666666666666666666666666666660500666666666600006666666666005555550066
6666666666666666666660006666600000666666000066666050006666666666666666666666666666666660000066666600555c550066666660000666000006
66666666666666666666000066660006666666666600066660500000066666666666666660066666666666000066666000000066666006666660666666666600
66660000000066660000006660000666600066006605066666000006666666666666666066666666666660000666660000666666666006666666666666666660
60000000055500000000000000006666606660006055066666666666666666666666000000006666600000066600000006666666666006666666666666666666
05555000555555550000555500066666600666660500666666600000660666666000000055000000000000000055500066666666606666666666666666666666
550000000000005550005cc500006666600066005506666660000000660666660555555555c5005550000555cc55000666666666666666666666600000666666
0000055555555005c50055000000006666600000066666600000660000666666cccc550000000000055005c55000000066666666666666666660006660006666
00555ccccccc555555050055cc55500666666666666660006666000666666666cc555555ccc55005555005000555000066666666666666666000666666666666
555ccc555000000000005cc55000055000006666660000000666660066666666cc55ccccc55555555500005ccc55c55500066666666666000006666666666666
5cccc55500000000555cc5500555500005500000000005500000000666666666ccccccc550000000000055cc5000000000000006000000000000066666666666
ccccc5555500005555cc55500005c00555000000000050000000006666666666cccccc5555500055555cc555000005c005500000000000500000000006666666
cccccccc5555555cccccc5550005c50000555c50000550066666666666666666ccccccccc555555ccccccc55500005c5000555cc555505500066666606666666
ccccccccccccccccccccccccccccccc55555ccc505cc50066666666666666666ccccccccccccccccccccccccccccccccc55555cccccccc500066666666666666
cccccccccccccccccccccc5555cccc5550005c50005c50066666666666666666ccccccccccccccccccccccc55555cccc5500005cccc55c500066666606666666
ccccccc5555555555ccc55500005c50555555500000550000666666666666666cccccccc5555555555ccc555000005c505555555005005500000666006666666
ccccc5555500005555cc55500005c00555000000000050000000006666666666cccccc55500000000555cc550055555000550000000000055500000066666666
55cccc550000000000055cc50000000000000600000000000066000066666666ccccccc555000000000005cc5500000550000066666600000000666666666666
0555cccc55555555500005ccc555550000666666666600006666660066666666cc5555cccccc55555c5050055ccc555006666666666666600006666666666666
0005555ccc555005c50050005500006666666666666666000666666666666666ccc5555555555000055005500000000066666666666666666600066660666666
500000000000000555005c500000066666000005506666660000000000066666555c550005550005550005ccc500000666666666666666666666000660006666
0555500055555555000055550006666660066666050066666660000066066666000055555c500000000000005555500666666666666666666666660000666666
00005000550000000000000550066666606666666050066666666666666666666600000000000000000000660000050066666666660066666666666666666666
66000000000000000000066000000666600666606605066666666666666666666666660006666666666600006666000000666666666006666666666666666666
66666666666666666660000666000066660000066605066660055550666666666666666606666666666666050666666000066666666006666666666666666660
66666666666666666666600066666006666666666000666660506666066666666666666666666666666666605066666660050000000066666660066666666000
66666666666666006666600066666660000000000066666660500066666666666666666666666666666666660500666666600055500666666660055000005006
66666666666600000666600666666666660000066666666660050006666666666666666666666666666666660500666666666666666666666666600000000666
66666666666600666660006666666666666666666666666666600055555555066666666666666666600666000000666666666666666666666666666666666666
66666666666660000006666666666666666666666666666666666666666666006666666666666666666000066666666666666666666666666666666666666666
7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c6666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666666666000666000006666666666666666666666666666666666666666666666666666666666666666000550066666666666666666666666666666666
66666666666666666666660506666666666666666666666666605500666666666666666666666666666666600666666000666666666666666666666660006666
66666666666666666666660506666666666666666666666666666005506666666666666666666666666666666666666666666666666666666666666666660066
66666666666666666666605066666666666666066666666666666666006666666666666666666666666666666666666666666606666666666666666660660066
66666000000666666666050666666666666666660666666666666660666666666666666666666600000666666666666666666660066666666666666666006666
66660006666066666600006666666666666666660666666666666666666666666666666666600005550006666666666666666600666666666666666666666666
600055000000000000006666666666666666666006666666666666666666666660000000000005cccc5000066666666666660000666666666666666666666666
55cccccc555500000000055500066666666000006666666666666666666666660000000000000000000055555000000000066666666666600066666666666666
cccc5005555500000000005c50000000000000666666666666666666666666660005555555555555555500005555550006666666666600066666666666666666
cc55ccccccccc55000000555555555555500066666660000000066666666666655555555cccccccccc5555550000055555000000500066600000000666666666
c55cccccc555ccc550000555cccc555000006666660050666660066666666666c555ccccccccccccccccc5555555ccccccc55550006660055066660066666666
ccccccc5550005c550555ccccc55000000060000005550000660066666666666ccccccccccccccccccccc5cccccc555500555550000005555000660066666666
cccccccc5555555555ccccc5555500000000055555cc55555500066666666666cccccccccccccccccccccccccc5555000005cc5055555cc55555500066666666
cccccccccccccccccccccccccc555555555555ccccc500066660006666666666cccccccccccccccccccccccccccc5555555ccc555ccccc500006660006666666
cccccccccccccccccccccccccccccccccccccccccc5500666666000066666666ccccccccccccccccccccccccccccccccccccccccccccc5500066666000006666
ccccccccccccccccccccccccccc555cc555ccccccc5500666660000666666666ccccccccccccccccccccccccccccc555ccccccccccccc5500066660000666666
cccccccccccc55ccccccccc55c55500005555555ccc550000000066666666666cccccccccccccccccccccccccccc55500055cc55555ccc555000000066666666
cccccccc550005c5555ccccc5555000000000005555555000000006666666666cccccccccccccccccccccccccccc555000055550005555555500000006666666
cccccccc555055c5500555ccccc5500000066666000500066660066666666666c555ccccccccccccccccc555ccccc55555555500066000500006660066666666
cc55ccccccccc55550000005555ccc55500066666660000660000666666666665555555cccccccccccc55555505555ccc5500005000666000006000066666666
ccc5555cccc555000000005550000000000006666666600000066666666666665555555555cccc55555555000000000000000000000000666000006666666666
ccccc555550000000000555550000666000000066666666666666666666666660000000555555555550000555555055506666666666666000666666666666666
05555555500550000000000006666666666600006666666666666666666666660000000000000000000550000000600000006666666666666006666666666666
6660050000600600000006666666666666666666066666666666666666666666666000000000055cc55000666666666666660000666666666666666666666666
66666000600066666660000666666666666666660666666666666666666666666666666666660000000066666666666666666660066666666666666666666666
66666660006666666666000066666666666666606666666666666666066666666666666666666666666666666666666666666600666666666666666666660666
66666666666666666666600006666666666666666666666666666600506666666666666666666666666666666666666666666666666666666666666600660066
66666666666666666666660506666666666666666666666666660555066666666666666666666666666666606666666660666666666666666666666666000666
66666666666666666666600506666666666666666666666666600066666666666666666666666666666666660000000506666666666666666666666006666666
66666666666666600000000666666666666666666666666666666666666666666666666666666666666666666600000666666666666666666666666666666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666dddddd77775555775555555544444444444444446666666677777777ee77ee7744444444555555544555555544444444666666666655556666666666
66666666d555557777c77c77577eee7542ee22dd29922bb46666666677777777ee77ee7745555555577577544577777555555554666666666558855666aaaa66
65555566d447755577c7cc7757eee77542522252252225246666666677777777ee77ee774577775555555554455555555757775466666666665885666a5aa5a6
66656666d474457577cccc775eee77e545552555555255546666666677777777ee77ee774555555557775754457777755555555466666666655995566aaaaaa6
65555566d444457577cc7c775ee770054eee2ddd9992bbb4eee5566677777777ee77ee774575775555555554455555555777775466666666665995666a5aa5a6
65555566d4444557775555775ee7eee54eee2ddd9992bbb45556566677777777ee77ee774555555557777554457775755555555466666666655335566aa55aa6
55555556d555557777fc9377595d5a5545552555555255545555566677777777ee77ee7745777755555555544555555557577554666666666653356666aaaa66
55555556dddddd77755555575555555544444444444444445556666677777777ee77ee7745555555444444444444444455555554666666666655556666666666
44444444555777774444444444444444777777777777777777777777777777777775777755555555555557444475555555555555666666666666666666666666
47775dde444444445eed55545e575d54777777777777777777777777777777777775777755555555555557444475555555555555666bb6666668866666666666
4ee75eee4d57ed755ddd5dd47ed7ed74744444474777777777777774777777777775777744444444444444444444444444444444666bb6666688886666555566
47755dd54de7ed7e5ee55ee47ed7ed747474474747777777777777747777777755577777eeeeeeeeeeeeeee44eeeeeeeeeeeeeee666bb6666888888666566566
444444444de7ed7e4444444444444444747447474777777777777774eeeeeeee44444444e989777e777777e44e777777777777776bbbbbb66668866666566566
4d57ed75444444445e575d5455555574444444444eee77777777eee4eeeeeeee77444477e989cabe777777e44e7777777777777766bbbb666668866665565566
4de7ed7e4555dd557ed7ed74ee5dd5747422224744447777777744444747747477744777eeeeeeeeeeeeeee44eeeeeeeeeeeeeee666bb6666668866665565566
4de7ed7e4ee5dd577ed7ed74ee5dd574747777474774777777774774477777747774477744444444444444444444444444444444666666666666666666666666
bb6bb6bb424244447272727733633633666666667777777766666666766677477477666744777777444444447777777777777744666666666666666666666666
bbbbbbbb424424427272772733333333696666967eed777755566666776777477477767744777777444444447777777777777744666656666665666666666686
6b66bb6b4224442472772727636633636a9999967ddd7777665666667444e747747e444744777777444444447777777777777744656556665655686866555866
bbbbbbbb4422424477772727333333336aaaa9967ee77777655666667eeee747747eeee744777777444444447777777777777744655556665555668666568566
363333632442424427727777363333636aaa999644444444665666667eeee747747eeee744777777444444447777777777777744656556665655686866586566
333633334422442427777277333633336aaa999677444477665666667eee77477477eee744755555eeeeeeee5555555555555744666656666665666665865566
3633363642244244772772723633363666a999667774477766666666777777477477777744755555777777775555555555555744666666666666666668565566
33363333424424427272727733363333666666667774477766666666444444477444444444755555eeeeeeee5555555555555744666666666666666686666666
666666666666666666666666666666666666666666666666d6c6466c666666666666666666666666666666666660066666000066660000666600006666666666
666666666666666666666666666666666666666666666666dc6646c666666666666666666666666666666666660dd06660dddd0660dddd0660dddd0666666666
666666666666666666666666666666666666666666666666d66646666666666666666666666666666660066660dccd060dccccd00dccccd00dccccd066666666
555555555555555555555555555555555555555555555555d4444444666666666666666666000066660dd06660dccd060dccccd00dccccd00dccccd066666666
588888885666666666666666888888886666666588888885d6c6466c666666666000000660dddd0660dddd06660cc06660dccd0660dddd060dccccd066666666
588888885666666666666666888888886666666588888885dc6646c66600006600dddd000ddccdd00ddccdd060dccd06660dd0666600006660dddd0666666666
588888885666666666666666888888886666666588888885d6664c6660dddd060ddccdd00dccccd00dccccd00dccccd060dccd06666666666600006666666666
555555555555555555555555555555555555555555555555dddddddd0dccccd00dccccd00dccccd00dccccd00dccccd00dccccd00dddddd06666666666666666
__gff__
0000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000010000000101010000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000001
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
3838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838
3335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335
3e3e3e3e3e3e3e3e3e3e3e2e3e2e3e3e3e3e3e2e2e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e2e2e3e3e3e3e3e3e3e3e2e3e3e3e2e3e3e3e2e3e3e3e2e3e3e3e3e3e3e3e2e2e3e3e3e3e3e3e3e2e3e3e3e2e3e3e3e2e2e3e3e3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e3e3e2e3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e3e2e3e2e3e3e
3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e2e3e3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e2e3e3e3e3e3e3e3e3e3e2e2e3e3e3e3e3e3e3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e2e2e3e3e3e3e3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e2e3e3e2e2e3e3e3e3e3e3e3e2e2e3e3e3e3e3e3e3e2e3e3e3e3e3e3e3e3e3e3e3e
2f3f3f2f2f2f2f2f3f2f2f2f2f2f2f2f3f3f2f2f2f2f2f2f3f2f2f2f2f2f2f2f3f3f2f2f2f2f2f2f2f2f3f3f3f2f2f2f2f2f2f2f2f2f2f2f3f2f2f2f2f2f2f2f2f2f3f2f2f2f2f2f2f2f2f2f2f3f2f2f2f2f2f2f2f2f2f2f3f2f3f3f2f2f2f2f2f2f2f2f2f3f2f2f3f2f2f2f2f2f3f3f2f3f3f2f2f2f2f2f3f2f2f2f2f2f2f2f
2525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525
2525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525252525
c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c81e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c81e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c8c8c8c8c8c8c8c8c8c8c8c8c8c8c8c83a0000000000000000002f2f2f2f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c8c8c8eaeaeaeaeaeaeaeac8c8c8c8c83a00000000000000002f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c8c8eaeaeaeaeaeaeaeaeaeac8c8c8c83a3d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
c8c8c825e83bc9cc3be724c8c8c8c8c837000000000000002f2f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
f6f6c825e83bcbca3be724c8f6f6f6c8380000000000000000002f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
d0d2c825c7c7c7c7c7c724c8d0d2d2c8332f2f2f2f2f2f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
d0d2c8e9c3c2c1c7c4c5ecc8d0d2d2c8000000000000000000002f2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
d0d2c8dbd9d9d9d9d9d9dac8d0d3d2c800000000000000002f2f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3b3a3a3a
c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000233737373737373737373737373737
c7d5d8c7d5e5c7d5e5c7c7d4c7c7d4c7000000000000002f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003838383838383838383838383838
c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c700000000002f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003333333333333333333333333333
d5d7d6c7d5d7d6c7d5e5c7d5d7d6c7c7000000002f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c700002f2f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c7c7d4c7d5d8c7c7d4c7c7d5e5c7d4c700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
3e2800102065420754202542075420254207542075420254201542075420254207542025420754206542075418604300042320430004300043000430004300043000430004300040000400004000040000400004
33040005096240c624136241c62424624274042c6042a20427204242041f2041e2041d2041e20420204252042b2042a204222041a204182041b20423204252041f2041c2041c2041f20422204000040000400004
3e2800102065420700202002070020754207002070020200202542070020200207002075420700206002070018604300042320430004300043000430004300043000430004300040000400004000040000400004
000a0020006000f6000f640014500400000000186500000007450114000c6501265000000132001d6500c5000000000000000000000000000000000965000000000000745017650186501a650176500965000000
401c002023054240541a0541c0541a05418054170541505417054180541a0541c0541a05418054170542105423054180541a054280541a054180542305415054230540c0541a0541c05426054180541705415054
4007002032623286231b623116230c62308623046230062317003180031a0031c0031a00318003170032100323003180031a003280031a003180032300315003230030c0031a0031c00326003180031700300003
4007001032643286431b643116430c64308643046430064317003180031a0031c0031a00318003170032100323003180031a003280031a003180032300315003230030c0031a0031c00326003180031700300003
4007000832653286531b653116530c65308653046530065317003180031a0031c0031a00318003170032100323003180031a003280031a003180032300315003230030c0031a0031c00326003180031700300003
300e002023633246331a6331c6331a63318633176331563317633186331a6331c6331a63318633176332163323633186331a633286331a633186332363315633236330c6331a6331c63326633186331763315633
d607002023073240731a0731c0731a07318073170731507317073180731a0731c0731a07318073170732107323073180731a073280731a073180732307315073230730c0731a0731c07326073180731707315073
d60800083545429454184540a4543145427454064542e4542540405404074042040417404064040440403404024040240400404324043a4043d40400404004040040400404004040040400404004040040400404
d11c00202427324273242532424324233242232421324213242132421324203242131420324213242032421318273182731825318243182331822318213182131821318213182131821320203182131820318203
d71c00201105111051110511105111051110511105111051110511105111051110510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e0510e051
d10e0020355723555235532355120e5720e5520e5320e512295722955229532295121a5721a5521a5321a512005020050200502005020c5420c5320c5220c5123c5003c5003c5003c50000502005020050200502
011c00203257532555325353051500005000050000500005245002450024500245002400500005000050000534575305553053530515000050000500005000050000500005000050000500005000050000500005
401c002023024240241a0241c0241a02418024170241502417024180241a0241c0241a02418024170242102423024180241a024280241a024180242302415024230240c0241a0241c02426024180241702415024
01020000030210c021120211b021200212a0212b02100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001
30030000033320333211332083321b3320f332213322a33225332313322a3022c302313022c3022c302273022b3022c3022e3022e3022e3022a30226302293022f3022e3022b3022f302293022c302273022b302
08070000326232e6433266331663316532f65332653306533065331653306533365332653306532f6532f653316532f64330633326232e62324623206231e6231c62319623156231462314623136231462313623
8e0e00201163311633116331163311633116331163311633116331163311633116330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e6330e633
460e0020356743565435634356140e6740e6540e6340e614296742965429634296141a6741a6541a6341a614006040060400604006040c6440c6340c6240c6143c6043c6043c6043c60400604006040060400604
871c00203277532755327353071500705007050070500705247052470524705247052470500705007050070534775307553073530715007050070500705007050070500705007050070500705007050070500705
4003000000001150612b06128061230611e06120061280612a0611f0611f0610d0610000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001
310700000167301673016730167301673016730167301673016530165301653016530165301653016530165301633016330163301633016330163301633016330161301613016130161301613016130161301613
__music__
03 0e0c0d49
03 0e0c0d05
03 050c0d0f
03 06080c04
03 04080907
03 1314154f
03 46484c44
03 44484947

