[array,dif]=greedy2();
difarr=findjump(dif);
cell=mergelast(difarr,array);
tcell=mergesorting(cell);
opticalcell=optical(tcell);
framematrix=testRightframe(opticalcell);
list=getpossibleframe(framematrix);
s=findshortest(list,framematrix);
array=[];
for i=1:size(s,2)
    array=[array,opticalcell{s(i)}];
end
savearray(array);