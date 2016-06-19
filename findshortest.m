function s=findshortest(list,framematrix)
maxvalue=0;
s=[];
s(1)=6;
used=zeros(1,48);
used(6)=1;
caculatemin(s,list{s(1)});

function []=caculatemin(arr,candi)
    if size(arr,2)==46
       for k=1:size(candi,2)
           if used(candi(k))==0 && candi(k)==10
                arr=[arr,candi(k)];
                value = 0;
                for l=1:size(arr,2)-1
                    value=value+framematrix(arr(l),arr(l+1));
                end
                if value > maxvalue
                    s=arr
                    maxvalue=value
                end
           end
       end
    else 
        for k=1:size(candi,2)

            if candi(k)==0 
                continue;
            end
            if used(candi(k))==0
                tarr=[arr,candi(k)];
                used(candi(k))=1;
                caculatemin(tarr,list{candi(k)});
                used(candi(k))=0;
            end
        end
    end
        
end
end