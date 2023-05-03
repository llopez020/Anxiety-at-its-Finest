building_data = {
    buildings_end = 0,
    xoffset_build = 0,
    yoffset_build = 63,
    xoffset_camera = 0,
    yoffset_camera = 63,
}
building_list = {}
building = {
    building_x_start = 0,
    building_x_end = 0,
    number_of_floors = 0, --min 1, max 4
    elements_per_floor = 0, --min 3, max 6
    door_slot = 0,
    brick_color = 0,
    roof_color = 0,
    max_spawners = 0,
    building_type = 0,
    id=0,
    item_list = {}
}
available_brick_colors = {15,8,13,5}
available_roof_colors = {13,4,0,1,5}
available_spawners = {247,247,247,247,247,247,14,15,16,44,40}

function building:new(building_x_start_,number_of_floors_,elements_per_floor_,brick_color_,roof_color_)
    self.__index = self
    return setmetatable
    ({
    building_x_start = building_x_start_, building_x_end = 0,
    number_of_floors = number_of_floors_, elements_per_floor = elements_per_floor_, door_slot = 1,
    brick_color = brick_color_, roof_color = roof_color_
    },
    self)
end

function cull_buildings()
    if((mapx+1)*8>building_list[1].building_x_end) then 
        for a in all(building_list[1].item_list) do -- remove items
            deleteobj(a)
        end
        del(building_list, building_list[1]) --remove building
    end
end

function translate_buildings(translationAmount)
    for a in all(building_list) do
        a.building_x_start -= translationAmount
        a.building_x_end -= translationAmount
    end
    building_data.buildings_end = building_list[#building_list].building_x_end
end

function create_buildings()
    while(building_data.buildings_end<(mapx+17)*8) do
        buildingToAdd = 
        building:new
        (building_data.buildings_end, -- new building starts at buildings end coordinate
        (flr(rnd(4)) + 1), -- number of floors = 1-4
        (flr(rnd(4)) + 3), -- elements per floor = 3-6
        available_brick_colors[(flr(rnd(#available_brick_colors)) + 1)], -- pick a random brick color from array
        available_roof_colors[(flr(rnd(#available_roof_colors)) + 1)]) -- pick a random roof color from array

        buildingToAdd.building_x_end = building_data.buildings_end+(8*(buildingToAdd.elements_per_floor+1+buildingToAdd.elements_per_floor+2))
        buildingToAdd.door_slot = (flr(rnd(buildingToAdd.elements_per_floor)) + 1)
        buildingToAdd.max_spawners = (flr(buildingToAdd.elements_per_floor/2)*buildingToAdd.number_of_floors)/3
        buildingToAdd.item_list = {}

        building_data.buildings_end = buildingToAdd.building_x_end

        map_x_start = (buildingToAdd.building_x_start/8)+1
        floor_x_start = map_x_start
        map_y_start = flr(building_data.yoffset_build/8)+1
        current_spawners = 0
        buildFloorOffset = 0
        buildingToAdd.building_type = flr(rnd(3))
        if buildingToAdd.building_type == 1 or buildingToAdd.building_type == 0 then 
        for i=1,buildingToAdd.number_of_floors,1 do
            for j=1,buildingToAdd.elements_per_floor-buildFloorOffset,1 do
                if i>1 then add(buildingToAdd.item_list,create_object("plat",52,floor_x_start*8+building_data.xoffset_camera,map_y_start*8,8,2)) end
                if((flr(rnd(4)))==1 and current_spawners<buildingToAdd.max_spawners) then
                    spawn = available_spawners[(flr(rnd(#available_spawners)) + 1)]
                    mset( floor_x_start, map_y_start-1, spawn)
                    if(spawn == 247) then
                        add(buildingToAdd.item_list,create_object("blob",247,floor_x_start*8+building_data.xoffset_camera,(map_y_start-1)*8,8,7) )
                        mset(floor_x_start,map_y_start-1,0)
                    end
                    if(spawn == 14) then
                        add(buildingToAdd.item_list,create_object("item",14,floor_x_start*8+building_data.xoffset_camera,(map_y_start-1)*8,8,8) )
                        mset(floor_x_start,map_y_start-1,0)
                    end
                    if(spawn == 15) then
                        add(buildingToAdd.item_list,create_object("item",15,(floor_x_start*8+building_data.xoffset_camera),(map_y_start-1)*8,8,8) )
                        mset(floor_x_start,map_y_start-1,0)
                    end
                    if(spawn == 16) then
                        add(buildingToAdd.item_list,create_object("item",16,(floor_x_start*8+building_data.xoffset_camera),(map_y_start-1)*8,8,8) )
                        mset(floor_x_start,map_y_start-1,0)
                    end
                    if(spawn == 44) then
                        add(buildingToAdd.item_list,create_object("item",44,(floor_x_start*8+building_data.xoffset_camera),(map_y_start-1)*8,8,8) )
                        mset(floor_x_start,map_y_start-1,0)
                    end
                    if(spawn == 40) then
                        add(buildingToAdd.item_list,create_object("item",40,(floor_x_start*8+building_data.xoffset_camera),(map_y_start-1)*8,8,8) )
                        mset(floor_x_start,map_y_start-1,0)
                    end
                    current_spawners += 1
                end
                floor_x_start += 2
            end
            map_y_start-=2
            buildFloorOffset = buildFloorOffset^^1
            floor_x_start = map_x_start+buildFloorOffset
        end
        else
            buildStructure(buildingToAdd)
        end

        add(building_list,buildingToAdd)
    end
end

function buildStructure(buildingToAdd,buildFloorOffset,build_y_coord)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    tempbuild_x = build_x_coord
    buildingToAdd.id=flr(rnd(6))
    struct = structure_list(buildingToAdd.id)
    build_y_coord = building_data.yoffset_camera-7
    for i in all(struct) do
        if i=='n' then build_y_coord=build_y_coord-8 build_x_coord=tempbuild_x else
         if i==247 then add(buildingToAdd.item_list,create_object("blob",i,build_x_coord,build_y_coord,8,8) ) 
         elseif i==16 then add(buildingToAdd.item_list,create_object("item",i,build_x_coord,build_y_coord,8,8) ) 
         elseif i==14 then add(buildingToAdd.item_list,create_object("item",i,build_x_coord,build_y_coord,8,8) ) 
         elseif i==40 then add(buildingToAdd.item_list,create_object("item",i,build_x_coord,build_y_coord,8,8) ) 
         elseif i==52 then add(buildingToAdd.item_list,create_object("plat",i,build_x_coord,build_y_coord,8,8) ) 

        elseif i!=0 then add(buildingToAdd.item_list,create_object("wall",i,build_x_coord,build_y_coord,8,8) ) end build_x_coord=build_x_coord+8 end
    end
end

function renderBuildings()
    for i in all(building_list) do
        buildingToAdd = i
        if buildingToAdd.building_type == 1 or buildingToAdd.building_type == 0 then 
        pal( 15, buildingToAdd.brick_color)
        buildGround(buildingToAdd)
        buildFloorOffset = 1
        build_y_coord = building_data.yoffset_camera-7-8-8
        for i=1,buildingToAdd.number_of_floors-1,1 do
            buildFloor(buildingToAdd,buildFloorOffset,build_y_coord)
            buildFloorOffset = buildFloorOffset^^1
            build_y_coord = build_y_coord-16
        end
        build_y_coord = build_y_coord+16
        buildRoof(buildingToAdd,build_y_coord)
        pal( 15, 15)
    end
    end
end

function buildGround(buildingToAdd)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    build_y_coord = building_data.yoffset_camera-7
    for i=1,buildingToAdd.elements_per_floor,1 do
        if (i == buildingToAdd.door_slot) then
            spr(58, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
            spr(59, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
        else
            spr(58, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
            spr(246, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
        end
    end
    spr(58, build_x_coord, build_y_coord, 1, 1)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    build_y_coord = build_y_coord-8
    for i=1,buildingToAdd.elements_per_floor,1 do
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
    end
    spr(58, build_x_coord, build_y_coord, 1, 1)
end

function buildFloor(buildingToAdd,buildFloorOffset,build_y_coord)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    if(buildFloorOffset == 1) then
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
        for i=1,buildingToAdd.elements_per_floor-1,1 do
            spr(58, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
            spr(246, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
        end
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
        spr(58, build_x_coord, build_y_coord, 1, 1)
    else
        for i=1,buildingToAdd.elements_per_floor,1 do
            spr(58, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
            spr(246, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
        end
        spr(58, build_x_coord, build_y_coord, 1, 1)
    end
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    build_y_coord = build_y_coord-8
    for i=1,buildingToAdd.elements_per_floor,1 do
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
    end
    spr(58, build_x_coord, build_y_coord, 1, 1)
end

function buildRoof(buildingToAdd,build_y_coord)
    build_x_coord = buildingToAdd.building_x_start-8+building_data.xoffset_camera
    rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
    build_x_coord = build_x_coord + 8*(buildingToAdd.elements_per_floor+buildingToAdd.elements_per_floor+2)
    rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    build_y_coord = build_y_coord - 8
    for i=1,buildingToAdd.elements_per_floor,1 do
        rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
        build_x_coord = build_x_coord + 8
        rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
        build_x_coord = build_x_coord + 8
    end
    rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
end

function buildGround(buildingToAdd)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    build_y_coord = building_data.yoffset_camera-7
    for i=1,buildingToAdd.elements_per_floor,1 do
        if (i == buildingToAdd.door_slot) then
            spr(58, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
            spr(59, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
        else
            spr(58, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
            spr(246, build_x_coord, build_y_coord, 1, 1)
            build_x_coord = build_x_coord + 8
        end
    end
    spr(58, build_x_coord, build_y_coord, 1, 1)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset_camera
    build_y_coord = build_y_coord-8
    for i=1,buildingToAdd.elements_per_floor,1 do
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
        spr(58, build_x_coord, build_y_coord, 1, 1)
        build_x_coord = build_x_coord + 8
    end
    spr(58, build_x_coord, build_y_coord, 1, 1)
end

function structure_list(id)
   if id==0 then return {47,13,13,47,13,13,47,'n',
                         0,47,13,247,13,47,'n',
                         0,0,47,0,47,40,'n',
                        'n',
                    0,0,0,0,0 } end
    if id==1 then return {47,13,13,47,13,13,47,'n',
                         0,47,13,16,13,47,'n',
                         0,0,47,0,47,'n' } end  
    if id==2 then return {47,13,13,13,13,47,'n',
                            0,47,47,13,47,'n',
                            0,0,0,13,0,'n',
                            0,52,0,13,'n',
                            0,0,0,63} end  
    if id==3 then return {0,225,'n',
                                224,227,224,'n',
                                0,224,247} end  

    if id==4 then return {0,226,0,226,'n',
                            224,227,227,226,'n',
                            0,224,227,227,224,'n',
                            0,0,224,224,'n',
                            0,0,0,247} end  
    if id==5 then return {0,0,0,0,225,0,0,0,247,'n',
                                52,0,224,224,227,227,227,'n',
                                14,0,0,247,224,227,227,'n',
                                0,0,0,0,247,224,224,'n',
                                0,0,227,227,'n',
                                0,0,227,227,227,227,227,'n',
                                0,0,224,227,227,224,224,'n',
                                0,0,0,224,224} end 
end 