function []=savearray(array)
for k=1:size(array,2);
    filename=sprintf('%d.jpg',array(k));
    pthes=imread(filename);
    filename=sprintf('sorted\\%d_%d.jpg',k,array(k));
    imwrite(pthes,filename,'jpg');
end