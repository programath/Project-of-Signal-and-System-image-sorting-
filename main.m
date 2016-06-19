[array,dif]=greedy2();
difarr=findjump(dif);
cell=mergelast(difarr,array);
tcell=mergesorting(cell);
opticalcell=optical(tcell);
framematrix=testRightframe(opticalcell);
[list,start,ending]=getpossibleframe(framematrix);
s=findshortest(list,framematrix,start,ending);
array=[];
for i=1:size(s,2)
    array=[array,opticalcell{s(i)}];
end
savearray(array);