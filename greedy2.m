function [framearray,dif]=greedy2()
%%
earth=zeros(4800,3186);
framearray=zeros(1,3186);
dif=zeros(1,3185);
for i=1:3186
    filepath = sprintf('%d.jpg',i);
    patch = imread(filepath);
    patch=imresize(patch,[60,80]);
    graysmpatch=rgb2gray(patch);
    graysmpatch=double(graysmpatch);
    graysmpatch=graysmpatch./255;
    earth(:,i)=reshape(graysmpatch,size(graysmpatch,1)*size(graysmpatch,2),1);
end
covtotal=zeros(3186,3186);
for i=1:size(earth,2)
    for j=1:i
        covtotal(i,j)=norm(earth(:,i)-earth(:,j),1)/size(earth,1);
        covtotal(j,i)=covtotal(i,j);
    end
end 

cov2=corrcoef(earth);
cov=cov2-covtotal;
covtmp=cov;
cnt=1;
cellarr{cnt}=[];
totalsize=0;
while (totalsize<3186)
    link=[];
    i=1;
    while cov(i,1)==-1 
        i=i+1;
    end
    link(1,1)=i;
    link(1,2)=i;
    cov(i,:)=-1;

    for i=1:size(cov,2)-1
        t1=cov(:,link(i,1));
        t2=cov(:,link(i,2));
        max1=-1;
        max2=-1;
        link1=1;
        link2=1;
        for j=1:size(cov,2)
            if i==1
                if t2(j)>max2
                    link2=j;
                    max2=t2(j);
                end
            else
                if t2(j)>max2 && j~=link(i,2)
                    link2=j;
                    max2=t2(j);
                end
                %link(i,:) means at this moument the head is 1 and end is 2 then we should consider cov(link(i,1)) 
                %and cov(link(i,2)) and find the best  
                if t1(j)>max1 && j~=link(i,1)
                    link1=j;
                    max1=t1(j);
                end  
            end
        end
        
        if max(max1,max2) < 0.4
            
            break;
        else
            if max2 >= max1
                link(i+1,2)=link2;
                link(i+1,1)=link(i,1);
            end
            if max1 > max2
                link(i+1,1)=link1;
                link(i+1,2)=link(i,2);
            end
        end
        cov(link(i+1,1),:)=-1;
        cov(link(i+1,2),:)=-1;     
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
    cellarr{cnt}=array;
    totalsize=totalsize+size(cellarr{cnt},2);
    cnt=cnt+1;
end
totalcount=0;
for k=1:cnt-1
    for i=1:size(cellarr{k},2)
        totalcount=totalcount+1;
        framearray(totalcount)=cellarr{k}(1,i);
    end 
end

for k=1:totalcount-1
    dif(k)=covtmp(framearray(k),framearray(k+1));
end


% for k=1:totalcount
%     filename=sprintf('%d.jpg',framearray(k));
%     pthes=imread(filename);
%     filename=sprintf('sorted\\%d_%d.jpg',k,framearray(k));
%     imwrite(pthes,filename,'jpg');
% end
    