pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- game loop 

function _init()
	map_setup()
end

function _update()

end

function _draw()
	cls()
	draw_map()
end
-->8
-- map 
function map_setup()
	-- map tile setup
end

function draw_map()
	map(0,0,0,0,128,64)
end
__gfx__
04406666046666664066666666604666666046666660466666604666046666660466666666666666666666666c6666c66c6666c6444444446688666666666666
0ff066660f666666f06666666660f6666660f6666660f6666660f6660f6666660f66666666666666f44f6666c6c66c6cc6c66c6c44444444688668666dd6dd66
dddd6666dd666666dd66666666ddd66666ddd66666ddd66666ddd666dd666666ddf6666666666666dffd6666c6c00c6c66c00c664444444489866686dccd77d6
dddd6666dd666666dd66666666fddf6666fddf6666fddf6666fddf66dd666666dd66666666666666dddd666666044066c604406c4444444489866698dcccccd6
fccf6666fc666666cf666666666dd666666dd666666dd666666dd666fc666666ccc66666666666666dd66666c6dddd6c66dddd664444444489a666986dcccd66
6cc666666c666666c666666660c6166666c166666016c666661c6666cc666666660666664fddc6666cc6666666dccd66c6dccd6c4444444489aaaa8666dcd666
61166666616666661666666666660666660066666666066666006666006666666666666600ddfc0660066666c6f00f6c66f00f6644444444689aa986666d6666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666444444446689986666666666
66666666600666660066666600666666644666666446666644666666655666666556666655666666644666664466666644666666646696664444444466666666
622622666ff66666ff666666ff6666666ff666664ff66666ff4666666ff666665ff66666ff566666644666664466666644666666496664664442444466666666
28827726f88f6666f86666668f666666f33f66664f3666663f466666000066665006666600566666000066660066666600666666444496664444444466666666
28888826f88f6666f86666668f666666f33f66666f3666663f666666700766666706666607666666700766667066666607666666649966662444442444424244
62888266f11f6666f16666661f666666f11f66666f1666661f666666f00f66666f0666660f666666400466664066666604666666646966664444444442444444
662826666ff666666f666666f6666666611666666616666616666666600666666606666606666666600666666066666606666666666666664424444444444424
666266666886666668666666866666666ff6666666f66666f6666666600666666606666606666666600666666066666606666666666666664444444224242444
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666664442444424444442
64664666646666666066666660660666696966666f66f6666666f666600000066dddddd600066666666cc6666000000666cccc6666666606bbbbb9bbbbbbbbbb
446664664966696600666666006660669f66f666ff666f6666f66f6604777740d222222d08066666666cc666044444406c7777c666666030b8bb9a9bbbbbbbbb
44444666994946660000066600000666ff9ff666fffff666ff666f6607477470d2ddddd20806666666cccc660ffffff0c777777c66660330828bb9bbbbbbbbbb
644466666949666660006666600066666f9f66666fff6666fffff66607744770d2d222d20806666666cccc66000ff000c777c77c00603306b8bbbbbb33333333
646466666969666660606666606066666f6f66666f6f66666fff666607744770d2ddd2d2080666666cccc7c60ccffcc06c7c777c33033066bbbbbb1b33333333
6666666666666666666666666666666666666666666666666f6f666607477470d22222d200066666c7cccccc0cf88fc066c777c603330666bbabb1a133344333
6666666666666666666666666666666666666666666666666666666604777740ddddddd208066666cc77cccc6cf88fc66c777cc660306666ba4abb1b34344443
666666666666666666666666666666666666666666666666666666666000000662222226000666666cccccc666ffff66ccccc66666066666bbabbbbb44444444
6886666688666666886666665777777777777777777777755555555575555557aaaaaaaa55555555fff4fff4444444446664444666666666bbbbbbbbb8bbb8bb
6446666644666666446666665777777777777777777777755555555577777777aaaaaaaa555555554444444445555554664545a466666666bbbbbbbb828b8a8b
88886666886666668866666657777777777777777777777555555555555555555555555555555555f4fff4ff4545445466454a5466644666bbbbbbbbb8bbb8bb
488466664866666684666666577777777777777777777775555555555555555555555555555555554444444445555554664545a466888866bbbbbbbb33333333
41146666416666661466666657777777777777777777777555555555555555555555555555555555fff4fff4454454546645455468844886bbbbbbbb33333333
61166666616666661666666657777777777777777777777577777777555555555555555555555555444444444555555466454aa466844866bbbbbbbb43333343
68866666686666668666666657777777777777777777777555555555555555555555555555555555f4fff4ff455555546645455466888866bbbbbbbb43444344
6666666666666666666666665555555555555555555555557777755555555555555555555555555544444444444444446646444468888886bbbbbbbb44444444
66666666666660000006666666666666666666666666666666666666666666006666666666666666666000066666666666666666666666666666666666666666
66666666666600666000066666666666666666666666666666660000000000506666666666666666660000000666666666666666666666666666666666666666
66666666666600666660006666666666666666666666666666600055555555066666666666666666600666000000666666666666666666666666666666666666
66666666666600660666006666666666666666666666666666005500000000666666666666666666666666600500666666666666666666666666666000666666
66666666666600000666600666666666660000066666666660050006666666666666666666666666666666660500666666666666666666666666600000000666
66666666666600000666600666666666660000066666666660050006666666666666666666666666666666660500666666666600006666666666005555550066
66666666666666006666600066666660000000000066666660500066666666666666666666666666666666660500666666600055500666666660055000005006
6666666666666666666660006666600000666666000066666050006666666666666666666666666666666660000066666600555c550066666660000666000006
66666666666666666666600066666006666666666000666660506666066666666666666666666666666666605066666660050000000066666660066666666000
66666666666666666666000066660006666666666600066660500000066666666666666660066666666666000066666000000066666006666660666666666600
66666666666666666660000666000066660000066605066660055550666666666666666606666666666666050666666000066666666006666666666666666660
66660000000066660000006660000666600066006605066666000006666666666666666066666666666660000666660000666666666006666666666666666660
66000000000000000000066000000666600666606605066666666666666666666666660006666666666600006666000000666666666006666666666666666666
60000000055500000000000000006666606660006055066666666666666666666666000000006666600000066600000006666666666006666666666666666666
00005000550000000000000550066666606666666050066666666666666666666600000000000000000000660000050066666666660066666666666666666666
05555000555555550000555500066666600666660500666666600000660666666000000055000000000000000055500066666666606666666666666666666666
0555500055555555000055550006666660066666050066666660000066066666000055555c500000000000005555500666666666666666666666660000666666
550000000000005550005cc500006666600066005506766660000000660666660555555555c5005550000555cc55000666666666666666666666600000666666
500000000000000555005c500000066666000005506666660000000000066666555c550005550005550005ccc500000666666666666666766666000660006666
0000055555555005c50055000000006666600000066666600000660000666666cccc550000000000055005c55000000066666666666666666660006660006666
0005555ccc555005c50050005500006666666666666666000666666666666666ccc5555555555000055005500000000066666666666666666600066660666666
00555ccccccc555555050055cc55500666666666666660006666000666666666cc555555ccc55005555005000555000066666666666666666000666666666666
0555cccc55555555500005ccc555550000666666666600006666660066666666cc5555cccccc55555c5050055ccc555006666666666666600006666666666666
555ccc555000000000005cc55000055000006666660000000666660066666666cc55ccccc55555555500005ccc55c55500066666666666000006666666666666
55cccc550000000000055cc50000000000000600000000000066000066666666ccccccc555000000000005cc5500000550000066666600000000666666666666
5cccc55500000000555cc5500555500005500000000005500000000666666666ccccccc550000000000055cc5000000000000006000000000000066666666666
ccccc5555500005555cc55500005c00555000000000050000000006666666666cccccc55500000000555cc550055555000550000000000055500000066666666
ccccc5555500005555cc55500005c00555000000000050000000006666666666cccccc5555500055555cc555000005c005500000000000500000000006666666
ccccccc5555555555ccc55500005c50555555500000550000666666666666666cccccccc5555555555ccc555000005c505555555005005500000666006666666
cccccccc5555555cccccc5550005c50000555c50000550066666666666666666ccccccccc555555ccccccc55500005c5000555cc555505500066666606666666
cccccccccccccccccccccc5555cccc5550005c50005c50066666666666666666ccccccccccccccccccccccc55555cccc5500005cccc55c500066666606666666
ccccccccccccccccccccccccccccccc55555ccc505cc50066666666666666666ccccccccccccccccccccccccccccccccc55555cccccccc500066666666666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666666666666000066666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666666666600000000666666666666666666666666666666666666666666666666666666666666666666600000666666666666666666666666666666666
66666666666666000666000006666666666666666666666666666666666666666666666666666666666666666000550066666666666666666666666666666666
66666666666666666666600506666666666666666666666666600066666666666666666666666666666666660000000506666666666666666666666006666666
66666666666666666666660506666666666666666666666666605500666666666666666666666666666666600666666000666666666666666666666660006666
66666666666666666666660506666666666666666666666666660555066666666666666666666666666666606666666660666666666666666666666666000666
66666666666666666666660506666666666666666666666666666005506666666666666666666666666666666666666666666666666666666666666666660066
66666666666666666666600006666666666666666666666666666600506666666666666666666666666666666666666666666666666666666666666600660066
66666666666666666666605066666666666666066666666666666666006666666666666666666666666666666666666666666606666666666666666660660066
66666660006666666666000066666666666666606666666666666666066666666666666666666666666666666666666666666600666666666666666666660666
66666000000666666666050666666666666666660666666666666660666666666666666666666600000666666666666666666660066666666666666666006666
66666000600066666660000666666666666666660666666666666666666666666666666666660000000066666666666666666660066666666666666666666666
66660006666066666600006666666666666666660666666666666666666666666666666666600005550006666666666666666600666666666666666666666666
6660050000600600000006666666666666666666066666666666666666666666666000000000055cc55000666666666666660000666666666666666666666666
600055000000000000006666666666666666666006666666666666666666666660000000000005cccc5000066666666666660000666666666666666666666666
05555555500550000000000006666666666600006666666666666666666666660000000000000000000550000000600000006666666666666006666666666666
55cccccc555500000000055500066666666000006666666666666666666666660000000000000000000055555000000000066666666666600066666666666666
ccccc555550000000000555550000666000000066676666666666666666666660000000555555555550000555555055506666666666666000666666666666666
cccc5005555500000000005c50000000000000666666666666666666666666660005555555555555555500005555550006666666666600066666666666666666
ccc5555cccc555000000005550000000000006666666600000066666666666665555555555cccc55555555000000000000000000000000666000006666666666
cc55ccccccccc55000000555555555555500066666660000000066666666666655555555cccccccccc5555550000055555000000500066600000000666666666
cc55ccccccccc55550000005555ccc55500066666660000660000666666666665555555cccccccccccc55555505555ccc5500005000666000006000066666666
c55cccccc555ccc550000555cccc555000006666660050666660066666666666c555ccccccccccccccccc5555555ccccccc55550006660055066660066666666
cccccccc555055c5500555ccccc5500000066666000500066660066666666666c555ccccccccccccccccc555ccccc55555555500066000500006660066666666
ccccccc5550005c550555ccccc55000000060000005550000660066666666666ccccccccccccccccccccc5cccccc555500555550000005555000660066666666
cccccccc550005c5555ccccc5555000000000005555555000000006666666666cccccccccccccccccccccccccccc555000055550005555555500000006666666
cccccccc5555555555ccccc5555500000000055555cc55555500066666666666cccccccccccccccccccccccccc5555000005cc5055555cc55555500066666666
cccccccccccc55ccccccccc55c55500005555555ccc550000000066666666666cccccccccccccccccccccccccccc55500055cc55555ccc555000000066666666
cccccccccccccccccccccccccc555555555555ccccc500066660006666666666cccccccccccccccccccccccccccc5555555ccc555ccccc500006660006666666
ccccccccccccccccccccccccccc555cc555ccccccc5500666660000666666666ccccccccccccccccccccccccccccc555ccccccccccccc5500066660000666666
cccccccccccccccccccccccccccccccccccccccccc5500666666000066666666ccccccccccccccccccccccccccccccccccccccccccccc5500066666000006666
66666666dddddd77ee5555775555555544444444444444446666666677777777ee77ee77444444442222222442222222444444446666ddd66655556666666666
66666666d5555577eec77c77577eee7544444444444444446666666677777777ee77ee77422222222772772442777772222222246dd6ddd66558855666aaaa66
65555566d4477555eec7cc7757eee7754ee444cc499444336666666677777777ee77ee77427777222222222442222222272777246ddddddd665885666a5aa5a6
66656666d4744575eecccc775eee77e545444454454444546666666677777777ee77ee77422222222777272442777772222222246ddddddd655995566aaaaaa6
65555566d4444575eecc7c775ee775555554455555544555eee5566677777777ee77ee7742727722222222244222222227777724dddddddd665995666a5aa5a6
65555566d4444557ee5555775ee7eee5eee44ccc999443335556566677777777ee77ee77422222222777722442777272222222246c66c66c655335566aa55aa6
55555556d5555577eefc9377590c0305eee44ccc999443335555566677777777ee77ee7742777722222222244222222227277224c66c66c66653356666aaaa66
55555556dddddd77e55555575555555555544555555445555556666677777777ee77ee774222222244444444444444442222222466c66c666655556666666666
44444444444444444444444444444444777777777777777777777777777777777777777755555555555555555555555555555555666666666666666666666666
45552cce2eef25544c2fecf22e2f2c24777777777777777777777777777777777777777755555555555555555555555555555555666336666668866666666666
4ee52eee2fff2cc44cefecfefecfecf4744444474777777777777774777777777777777744444444444444444444444444444444666336666688886666555566
45522cc22ee225544cefecfefecfecf47474474747777777777777747777777777777777eeeeeeeeeeeeeee44eeeeeeeeeeeeeee666336666888888666566566
44444444444444444444444444444444747447474777777777777774eeeeeeee44444444e777777e777777e44e77777777777777633333366668866666566566
4c2fecf22e2f2c244222cc22222222f4444444444eee77777777eee4eeeeeeee77444477e777777e777777e44e77777777777777663333666668866665565566
4cefecfefecfecf44ee2cc2fee2cc2f47422224744447777777744444747747477744777eeeeeeeeeeeeeee44eeeeeeeeeeeeeee666336666668866665565566
4cefecfefecfecf44444444444444444747777474774777777774774477777747774477744444444444444444444444444444444666666666666666666666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
65666666555666665556666656566666555666665556666655566666555666665556666655566666666666666666666656666666666656666665666666666686
55666666665666666656666656566666566666665666666666566666565666665656666656566666566566665556666656666666656556665655686866555866
65666666555666665556666655566666555666665556666665566666555666665556666656566666665666666656666656666666655556665555668666568566
65666666566666666656666666566666665666665656666666566666565666666656666656566666656666666556666656666666656556665655686866586566
55566666555666665556666666566666555666665556666666566666555666666656666655566666566566666666666666666666666656666665666665865566
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666566666656666666666666666666666668565566
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666686666666
666666666666666666666666666666666666666666666666d6c6466c6666666666666666666666666666666666600666660000666600006666000066eeeeeeee
666666666666666666666666666666666666666666666666dc6646c666666666666666666666666666666666660dd06660dddd0660dddd0660dddd06eeeeeeee
666666666666666666666666666666666666666666666666d66646666666666666666666666666666660066660dccd060dccccd00dccccd00dccccd0eeeeeeee
555555555555555555555555555555555555555555555555d4444444666666666666666666000066660dd06660dccd060dccccd00dccccd00dccccd0eeeeeeee
588888885666666666666666888888886666666588888885d6c6466c666666666000000660dddd0660dddd06660cc06660dccd0660dddd060dccccd077777777
588888885666666666666666888888886666666588888885dc6646c66600006600dddd000ddccdd00ddccdd060dccd06660dd0666600006660dddd067e7e7e7e
588888885666666666666666888888886666666588888885d6664c6660dddd060ddccdd00dccccd00dccccd00dccccd060dccd06666666666600006622222222
555555555555555555555555555555555555555555555555dddddddd0dccccd00dccccd00dccccd00dccccd00dccccd00dccccd00dddddd06666666622222222
__map__
3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a000000000000000000000000000000000000003e3f3e3e00000000000000000000000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3a3a3a3a3a3a3a3a3a3a3a3a3af6f63a3a0000000000000000000000000000000000002e3e0d2f2f0000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3affffffffffffffff3a3a3af6f6f6f63a0000000000000000000000000000000000003e2f0d0d1e00000000c8000000000000000000000000000000c80000000000000000000000000000c8000000000000000000000000000000c8000000000000000000000000000000c8000000000000000000000000000000c800000000
ffffffffffffffffffff3a3af6f6f6f63a0d3ac800000000000000000000000000003e2f0d0d1e1e000000c83ac800000000c8c8c8c80000000000c83ac8000000c8c8c8c80000000000c83ac800000000c8c8c8c80000000000c83ac800000000c8c8c8c80000000000c83ac800000000c8c8c8c80000000000c83ac8000000
ffc8c83bc9cc3bc8c8ff3a3a3a3a3a3a3a0d3ac8c8000000000000000000000000003e0d0d0d1e1e0000c83a3a3ac80000c8c8c8c8c8c8000000c83a3a3a0000c8c8c8c8c8c8000000c83a3a3ac80000c8c8c8c8c8c8000000c83a3a3ac80000c8c8c8c8c8c8000000c83a3a3ac80000c8c8c8c8c8c8000000c83a3a3ac80000
3ac8c83bcbca3bc8c83a3a3ad0d3d2d13a0d3a3a000035350000000000000000003e3f0d0d1e1e1e0000003a3a3a000000003a3a3a3a00000000003a3a3a0000003a3a3a3a00000000003a3a3a000000003a3a3a3a00000000003a3a3a000000003a3a3a3a00000000003a3a3a000000003a3a3a3a00000000003a3a3a000000
3ac8c8c8c8c8c8c8c83a3a3ad2d1d3d33a0d3acc0000000000353535003500003e2e0d0d0d1e1e1e0000003a3a3a000000003af63acc00000000003a3a3a0000003af63acc00000000003a3a3a000000003af63acc00000000003a3a3a000000003af63acc00000000003a3a3a000000003af63acc00000000003a3a3a000000
3ac1c8c4c5c8c3c2c83a3a3ad2d3d1d33a0d0d3a00000000000000000000003e3e2f0d0d1e1e1e1e0000003a3a3a000000003a3a3a3a00000000003a3a3a0000003a3a3a3a00000000003a3a3a000000003a3a3a3a00000000003a3a3a000000003a3a3a3a00000000003a3a3a000000003a3a3a3a00000000003a3a3a000000
c7dbd9d9d9d9d9d9dac7c7c7c7c7c7c7c70d0d3737373e3535353e3e3e3e3e3e3f0d0d1e1e1e1e1e37373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737373737
c7c7c7c7c7c7c7c7c7c7c7c7c7d4d4c7c70d0d38383e3e3e3e3e3e3e2e3e3e2f0d0d0d1e1e1e1e1e38383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838383838
c7d5d8c7d5d8c7d5d8c7d5d8c7c7c7c7c70d0d0d2f2f2f2f3f2f2f2f2f2f2f0d0d0d1e1e1e1e1e0d33353335333533353335333533353335333533353335353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533353335333533
c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c70d0d0d0d0d0d0d0d0d0d0d1e0d0d0d0d0d1e1e1e1e1e1e0d0d0d0d0d0d1e0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d1e0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d1e0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d1e0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d1e0d0d
d5d7d6c7d5d7d6c7d5d7d6c7c7c7c7c7c70d0d0d0d0d0d1e1e0d1e1e1e0d0d0d0d1e1e1e1e1e1e1e0d1e1e0d1e1e1e0d0d0d0d0d0d0d0d0d0d1e1e0d1e1e0d0d0d0d0d0d0d0d0d0d1e1e0d1e1e1e0d0d0d0d0d0d0d0d0d0d1e1e0d1e1e1e0d0d0d0d0d0d0d0d0d0d1e1e0d1e1e1e0d0d0d0d0d0d0d0d0d0d1e1e0d1e1e1e0d0d
c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c70d0d0d1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e0d1e1e0d0d0d0d1e1e0d1e1e1e1e1e0d1e1e0d0d0d0d1e1e0d1e1e1e1e1e1e0d1e1e0d0d0d0d1e1e0d1e1e1e1e1e1e0d1e1e0d0d0d0d1e1e0d1e1e1e1e1e1e0d1e1e0d0d0d0d1e1e0d1e1e1e1e1e1e0d1e
d5d7d6c7d5d7d6c7d5d7d6c7c7c7c7c7c70d0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d0d1e1e1e1e1e1e1e1e1e1e1e1e1e0d0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d0d1e1e1e1e1e1e1e1e1e1e1e1e
c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c7c71e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e0d1e1e1e1e1e1e1e1e1e1e1e1e
33343434343434343434343434343434351e1e1e1e1e1e1e1e1e1e1e1e1e1e1e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000003a3a3a3a3a3a3a3a3a3a3a3a3a3a0000000000000000000d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000003a3a3a3a3a3a3a3a3a3a3a3a3a3a00000000000000000d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000003a3a3a3a3a3a3a3a3a3a3b3a3a3a3d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
0000233737373737373737373737373737000000000000000d0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
00000038383838383838383838383838380000000000000000000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
0000003333333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
00000000000000000000000000000000000000000000000000000d0d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3a3a3a3a
0000000000000000000000000000000000000000000000000d0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003a3a3a3a3a3a3a3a3a3a3b3a3a3a
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000233737373737373737373737373737
00000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003838383838383838383838383838
0000000000000000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003333333333333333333333333333
00000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000d0d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000