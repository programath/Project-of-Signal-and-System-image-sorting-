%% matrix(i,j)= whether j is after i?1��0
function [framematrix,script]=testRightframe(cell)
framematrix=zeros(size(cell,2));
script=zeros(size(cell,2));
    for k=1:size(cell,2)
        for j=1:size(cell,2)
            if k==j
                framematrix(k,j) = 0;
            else
                [framematrix(k,j),script(k,j)] = Rightframe(cell{k}(size(cell{k},2)), cell{j});
            end
        end
    end
end


function [sign,scrsign]=Rightframe(n,array)
maxvalue = 0;
sign = 1;
filename=sprintf('..\\%d.jpg',n);
patch=imread(filename);
gpatch=rgb2gray(patch);
smpatch=double(gpatch(400:435,50:120));
scr1=double(gpatch(365:445,130:480));
lpatch=reshape(smpatch,size(smpatch,1)*size(smpatch,2),1);
scrpatch=reshape(scr1,size(scr1,1)*size(scr1,2),1);
for i=1:4
    f=sprintf('..\\%d.jpg',array(i));
    patch=imread(f);
    graypatch=rgb2gray(patch);
    smgraypatch=double(graypatch(400:435,50:120));
    tpatch=reshape(smgraypatch,size(smgraypatch,1)*size(smgraypatch,2),1);
    scr2=double(graypatch(365:445,130:480));
    scr2patch=reshape(scr2,size(scr2,1)*size(scr2,2),1);
    corr=corrcoef(lpatch,tpatch);
    corr2=corrcoef(scrpatch,scr2patch);
    if corr2(1,2)<0.985
        corr2(1,2)=0;
    end
    if i == 1
        if corr(1,2)<0.985
            sign = 0;
            scrsign = 0;
            return
        else
            sign = corr(1,2);
            scrsign = corr2(1,2);
        end
        maxvalue = corr(1,2);
    elseif corr(1,2) > maxvalue + 0.0005 
        %sign = 0;
        %scrsign = 0;
        return
    end 
end
end