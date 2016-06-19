function cell=optical(cellold)
cell=cellold;
opticFlow = opticalFlowFarneback;
totalnum=size(cell,2);
for i=1:totalnum
    start=cell{i}(1);
    ending1=cell{i}(min(size(cell{i},2),10));
    ending2=cell{i}(min(size(cell{i},2),20));
    ending =cell{i}(min(size(cell{i},2),30));
    for k=1:4
        if k==1
            filename=sprintf('..\\%d.jpg',start); 
        end
        if k==2
            filename=sprintf('..\\%d.jpg',ending1);
        end
        if k==3
            filename=sprintf('..\\%d.jpg',ending2);
        end
        
        if k==4
            filename=sprintf('..\\%d.jpg',ending);
        end
        p1=imread(filename);
        frameGray=rgb2gray(p1);
        sframeGray=frameGray(400:419,50:120);
        gausFilter = fspecial('gaussian',[5 5],1.5);
        fblur=imfilter(sframeGray,gausFilter,'replicate');
        flow = estimateFlow(opticFlow,fblur); 
        realvx=bsxfun(@times, flow.Vx, flow.Magnitude);
        vx(k)=sum(sum(realvx,1),2);
        if  k==4 
            vx(1)=0;
            vabs=abs(vx);
            maxvx=max(vabs);
            m=find(maxvx==vabs);
            if vx(m)<0
                i
                n=size(cell{i},2);
                for t=1:floor(n/2)
                    tmp=cell{i}(t);
                    cell{i}(t)=cell{i}(n-t+1);
                    cell{i}(n-t+1)=tmp;
                end
            end
        end
    end
%     f=sprintf('sorted\\%d',i);
%     mkdir(f);
%     for l=1:size(cell{i},2)
%         filename=sprintf('%d.jpg',(cell{i}(1,l)));
%         pthes=imread(filename);
%         filename=sprintf('sorted\\%d\\%d_%d.jpg',i,l,(cell{i}(1,l)));
%         imwrite(pthes,filename,'jpg');
%     end
end

