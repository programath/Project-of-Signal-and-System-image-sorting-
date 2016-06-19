%% sort inside the cell
function newcell=mergesorting(cell)
    for i=1:size(cell,2)
        newcell{i}=reorder(cell,i);
    end
end

function array=reorder(cell,n)
%%
label=[];
bcasttotal=[];
count=0;
for i=1:size(cell{n},2)
    filename=sprintf('..\\%d.jpg',cell{n}(i));
    patch=imread(filename);
    graypatch=rgb2gray(patch);
    graypatch=double(graypatch);
    total = graypatch(400:435,50:120);
    %total = imresize(graypatch,[60,80]);
    count=count+1;
    bcasttotal(:,count)=reshape(total, size(total,1)*size(total,2),1);
    label(count)=cell{n}(i);
end
% we choose corrcoef coefficient as the criteria of similarity 
% covu3=corrcoef(bcastu3);
% covtotal=corrcoef(bcasttotal);
% cov2=corrcoef(sort);
% cov=covtotal+cov2;
% cellar=greedy(cov,cov2,label,id,count);

%here we choose clockcity as the criteria of simialarity
bcasttotal=bcasttotal./255;
covtotal=zeros(size(bcasttotal,2),size(bcasttotal,2));
for i=1:size(bcasttotal,2)
    for j=1:i
        covtotal(i,j)=norm(bcasttotal(:,i)-bcasttotal(:,j),1)/size(bcasttotal,1);
        covtotal(j,i)=covtotal(i,j);
    end
end 

cov=covtotal;
link(1,1)=1;
link(1,2)=1;

for i=1:size(cov,2)-1
    t1=cov(:,link(i,1));
    t2=cov(:,link(i,2));
    min1=inf;
    min2=inf;
    link1=1;
    link2=1;
    for j=1:size(cov,2)
        if i==1
            if t2(j)<min2 && j~=1
                link2=j;
                min2=t2(j);
            end
        else
            if t2(j)<min2 && j~=link(i,2)
                link2=j;
                min2=t2(j);
            end
            %link(i,:) means at this moument the head is 1 and end is 2 then we should consider cov(link(i,1)) 
            %and cov(link(i,2)) and find the best  
            if t1(j)<min1 && j~=link(i,1)
                link1=j;
                min1=t1(j);
            end  
        end
    end

    if min2 <= min1
        link(i+1,2)=link2;
        link(i+1,1)=link(i,1);
    end
    if min1 < min2
        link(i+1,1)=link1;
        link(i+1,2)=link(i,2);
    end
    cov(link(i+1,1),:)=1;
    cov(link(i+1,2),:)=1;     
end
array=[];
frame=1;
for i=size(link,1):-1:1
    if (frame>1)
        if link(i,1)~=array(frame-1)
            array(frame)=link(i,1);
            frame=frame+1;
        end
    else
        array(frame)=link(i,1);
        frame=frame+1;
    end
end
for i=1:size(link,1)
   if link(i,2)~=array(frame-1)
        array(frame)=link(i,2);
        frame=frame+1;
   end
end
mincost=0;
cost=0;
for i=1:size(array,2)-1
    mincost=mincost+covtotal(array(i),array(i+1));
end
tarray=array;
% front search
for i=3:size(link,1)
    newarray=[tarray(2:i-1),tarray(1),tarray(i:end)];
    cost=0;
    for j=1:size(newarray,2)-1
        cost=cost+covtotal(newarray(j),newarray(j+1));
    end
    if cost < mincost
        mincost=cost;
        array=newarray;
    end
end
tarray=array;
mincost=0;
cost=0;
for i=1:size(array,2)-1
    mincost=mincost+covtotal(array(i),array(i+1));
end
% back search
for i=size(link,1)-1:-1:2
    newarray=[tarray(1:i-1),tarray(end),tarray(i:end-1)];
    cost=0;
    for j=1:size(newarray,2)-1
        cost=cost+covtotal(newarray(j),newarray(j+1));
    end
    if cost < mincost
        mincost=cost;
        array=newarray;
    end
end
array=label(array);
end

