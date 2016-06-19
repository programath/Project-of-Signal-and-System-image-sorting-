function difarr=findjump(dif)
secdif=diff(dif);
count=2;
arr=find(secdif>0.25);
difarr(1)=0;
difarr(2)=arr(1);
for i=2:size(arr,2)
    if arr(i)-arr(i-1)>25
        count=count+1;
        difarr(count)=arr(i);
    end 
end
difarr=[difarr,size(dif,2)+1];
