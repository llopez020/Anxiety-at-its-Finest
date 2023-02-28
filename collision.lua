function sprcoll(x,y,w,h,x2,y2,w2,h2)
   
 col=false
 w=w-1
 h=h-1
 w2=w2-1
 h2=h2-1

 -- debug show hitboxes
 if (debugint==1) then rect(x,y,x+w,y+h,8) rect(x2,y2,x2+w2,y2+h2,8) end

 if ((x<x2+w2) and (x+w>x2) and (y<y2+h2) and (y+h>y2)) then
  col=true return col
 end
   
 return col
    
end