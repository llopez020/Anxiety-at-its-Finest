building_data = {
    buildings_end = 0,
    xoffset = 0,
    yoffset = 63
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
}
available_brick_colors = {15,8,13,5}
available_roof_colors = {13,4,0,1,12,5}

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

function new_building()
    buildingToAdd = 
    building:new
    (building_data.buildings_end, -- new building starts at buildings end coordinate
    (flr(rnd(4)) + 1), -- number of floors = 1-4
    (flr(rnd(4)) + 3), -- elements per floor = 3-6
    available_brick_colors[(flr(rnd(#available_brick_colors)) + 1)], -- pick a random brick color from array
    available_roof_colors[(flr(rnd(#available_roof_colors)) + 1)]) -- pick a random roof color from array

    buildingToAdd.building_x_end = building_data.buildings_end+(8*(buildingToAdd.elements_per_floor+1+buildingToAdd.elements_per_floor+2))
    buildingToAdd.door_slot = (flr(rnd(buildingToAdd.elements_per_floor)) + 1)

    building_data.buildings_end = buildingToAdd.building_x_end

    add(building_list,buildingToAdd)
end

function renderBuildings()
    for i in all(building_list) do
        buildingToAdd = i
        pal( 15, buildingToAdd.brick_color)
        buildGround(buildingToAdd)
        buildFloorOffset = 1
        build_y_coord = building_data.yoffset-7-8-8
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
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset
    build_y_coord = building_data.yoffset-7
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
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset
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
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset
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
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset
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
    build_x_coord = buildingToAdd.building_x_start-8+building_data.xoffset
    rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
    build_x_coord = build_x_coord + 8*(buildingToAdd.elements_per_floor+buildingToAdd.elements_per_floor+2)
    rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
    build_x_coord = buildingToAdd.building_x_start+building_data.xoffset
    build_y_coord = build_y_coord - 8
    for i=1,buildingToAdd.elements_per_floor,1 do
        rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
        build_x_coord = build_x_coord + 8
        rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
        build_x_coord = build_x_coord + 8
    end
    rectfill( build_x_coord, build_y_coord, build_x_coord+7, build_y_coord-7, buildingToAdd.roof_color)
end