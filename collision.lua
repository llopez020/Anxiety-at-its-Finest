function sprcoll(x,y,w,h,x2,y2,w2,h2)
   
 col=false

 -- debug show hitboxes
 if (debugint==1) then rect(x,y,x+w,y+h,8) rect(x2,y2,x2+w2,y2+h2,8) end

 if ((x<x2+w2) and (x+w>x2) and (y<y2+h2) and (y+h>y2)) then
  col=true return col
 end
   
 return col
    
end

function tilecoll(x,y,w,h)
   
    col=false
    -- debug show hitboxes
    //if (debugint==1) then rect(x,y,x+w,y+h,8) end
    
    rx=-(realmapx)/8
    ry=-(realmapy)/8
    ry=ry+0.125
    for i=x,x+w,w do
        if (fget(mget((i/8)+rx,(y/8)+ry),0)==true) or (fget(mget((i/8)+rx,((y+h)/8)+ry),0)==true) then
            col=true
            return col
        end
    end

    for i=y,y+h,h do
        if (fget(mget((x/8)+rx,(i/8)+ry),0)==true) or (fget(mget(((x+w)/8)+rx,(i/8)+ry),0)==true) then
            col=true
            return col
        end
    end

    return col
       
end