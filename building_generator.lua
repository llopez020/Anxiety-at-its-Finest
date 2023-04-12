building_data = {
    buildings_end = 0,
    xoffset_build = 0,
    yoffset_build = 63,
    xoffset_camera = 0,
    yoffset_camera = 63
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
    max_spawners = 0
}
available_brick_colors = {15,8,13,5}
available_roof_colors = {13,4,0,1,5}
available_spawners = {247,40,44}

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

function create_buildings()
    while(building_data.buildings_end<128*8) do
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

        building_data.buildings_end = buildingToAdd.building_x_end

        map_x_start = (buildingToAdd.building_x_start/8)+1
        floor_x_start = map_x_start
        map_y_start = flr(building_data.yoffset_build/8)+1
        current_spawners = 0
        buildFloorOffset = 0
        for i=1,buildingToAdd.number_of_floors,1 do
            for j=1,buildingToAdd.elements_per_floor-buildFloorOffset,1 do
                if i>1 then mset( floor_x_start, map_y_start, 52) end
                if((flr(rnd(6)))==1 and current_spawners<buildingToAdd.max_spawners) then
                    spawn = available_spawners[(flr(rnd(#available_spawners)) + 1)]
                    mset( floor_x_start, map_y_start-1, spawn)
                    if(spawn == 247) then
                        --create_object("blob",247,floor_x_start*8,(map_y_start-1)*8,8,7) 
                        --mset(floor_x_start,map_y_start-1,0)
                    end
                    current_spawners += 1
                end
                floor_x_start += 2
            end
            map_y_start-=2
            buildFloorOffset = buildFloorOffset^^1
            floor_x_start = map_x_start+buildFloorOffset
        end

        add(building_list,buildingToAdd)
    end
end

function renderBuildings()
    for i in all(building_list) do
        buildingToAdd = i
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