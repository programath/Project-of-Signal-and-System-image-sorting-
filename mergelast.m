function cell=mergelast(difarr,array)
cnt=0;
% for i=1:size(difarr,2)-1
%     cnt=cnt+1;
%     flod=sprintf('result\\%d',cnt);
%     mkdir(flod);
%     for j=(difarr(i)+1):difarr(i+1)
%         f=sprintf('%d.jpg',array(j));
%         p=imread(f);
%         f=sprintf('result\\%d\\%d.jpg',cnt,array(j));
%         imwrite(p,f,'jpg');
%     end
% end
for i=1:size(difarr,2)-1
    cnt=cnt+1;
    cell{cnt}=(difarr(i)+1):difarr(i+1);
    cell{cnt}=array(cell{cnt});
end