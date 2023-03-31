animation_data = {}
animation_data_once = {}
animation = {
    pos_x = 0,
    pos_y = 0,
    sprite_indices = {},
    sprite_width = 0,
    sprite_height = 0,
    frame_cycle = 1,
    current_frame = 1,
    flipped = false
}

function animation:new(pos_x_,pos_y_,sprite_indices_,sprite_width_,sprite_height_,frame_cycle_)
    self.__index = self
    return setmetatable
    ({
    pos_x = pos_x_, pos_y = pos_y_,
    sprite_indices = sprite_indices_, sprite_width = sprite_width_, 
    sprite_height = sprite_height_, frame_cycle = frame_cycle_
    },
    self)
end

function animate(object,pos_x,pos_y,sprite_indices,sprite_width,sprite_height,frame_cycle,flipped)
    if (object==nil) then
        return
    end    
    if (animation_data[obj_hash(object)]==nil) then
        a = animation:new(pos_x,pos_y,sprite_indices,sprite_width,sprite_height,frame_cycle)
        if (flipped!=nil) then
            a.flipped = flipped
        end
        animation_data[obj_hash(object)] = a
    end
    animation_data[obj_hash(object)].flipped = flipped
    animation_data[obj_hash(object)].pos_x = pos_x
    animation_data[obj_hash(object)].pos_y = pos_y
    play_animation(animation_data[obj_hash(object)])
end

function animate_once(pos_x,pos_y,sprite_indices,sprite_width,sprite_height,frame_cycle,num_cycles,flipped)
    a = animation:new(pos_x,pos_y,sprite_indices,sprite_width,sprite_height,frame_cycle)
    if (flipped!=nil) then
        a.flipped = true
    end
    add(animation_data_once,{anim=a,num_cycles=(#a.sprite_indices*num_cycles)}) 
end

function handle_animations()
    for a in all(animation_data_once) do
        if (a.anim.current_frame % a.anim.frame_cycle == 0) then
            a.num_cycles = a.num_cycles - 1
        end
        if (a.num_cycles == 0) then
            del(animation_data_once,a)
            break
        end
        play_animation(a.anim)
    end
end

function play_animation(animation)
    spr_select = flr((animation.current_frame/animation.frame_cycle))
    if(spr_select >= #animation.sprite_indices ) then
        animation.current_frame = 0
        spr_select = 0
    end
    spr(animation.sprite_indices[spr_select+1], animation.pos_x, animation.pos_y, animation.sprite_width, animation.sprite_height, animation.flipped)
    animation.current_frame = animation.current_frame+1
end

local NEXT_HASH, HASHES = 1, setmetatable({}, {__mode="k"})
function obj_hash(obj)
    local hash = HASHES[obj]
    if not hash then
        hash = NEXT_HASH
        HASHES[obj], NEXT_HASH = hash, hash + 1
    end
    return hash
end