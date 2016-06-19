function [list,start,ending]=getpossibleframe(framematrix)
start = 0;
ending = 0;
tmpmatrix=framematrix;
for i=1:size(framematrix,2)
    [max1,id1]=max(tmpmatrix(i,:));
    tmpmatrix(i,id1)=0;
    [max2,id2]=max(tmpmatrix(i,:));
    tmpmatrix(i,id2)=0;
    [max3,id3]=max(tmpmatrix(i,:));
    if max(framematrix(:,i))==0 && max1 ~= 0
        start=i;
        continue;
    end
    if max1 == 0 && max(framematrix(:,i)) ~= 0
        list{i}=0;
        ending=i;
        continue;
    end
    if max1 == 0 && max(framematrix(:,i)) == 0
        continue;
    end
    if max1-max3<0.004 && max1 ~= 0
        list{i}=[id1,id2,id3];
    else
        if max1-max2<0.004
            list{i}=[id1,id2];
        else
            list{i}=[id1];
        end
    end
end