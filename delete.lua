function deleteobj(a)
    local temp = objlist
    local temp2 = objlist
    while temp do
     if temp.value==a then temp2.next=temp.next goto leave end
     temp2 = temp
        temp = temp.next
    end
    ::leave::
end

function deleteallof(a, range)
    local temp = objlist
    local temp2 = nil
    while temp do
     if temp.value.id==a and (abs(temp.value.x-range))<100 then temp2.next=temp.next end
     temp2 = temp
        temp = temp.next
    end
end