% WRITE HERE YOUR FUNCTION FOR EXERCISE 9

function [A,num] = wordscountstarting(n,c)

fileName = 'LittleMermaid.txt';
FID = fopen(fileName);
data = textscan(FID,'%s');
fclose(FID);
stringData = string(data{:});
stringData = lower(stringData);

num=0;
for i=1:length(stringData)
    sd = char(stringData(i));
    if sd(1) == c
        num=num+1;
        cword{num} = char(stringData(i));
    end
end

k=1;
a=unique(cword,'stable');
b=cellfun(@(x) sum(ismember(cword,x)),a,'un',0);

for i=1:length(a)
    s = char(a(i));
    if s(1) == c
        wrd(k) = a(i);
        occ(k) = b(i);
        k = k + 1;
    end   
end
% wrd;
% occ;
% unique(wrd);
% w=string(wrd);
% occ;
%c=cellfun(@str2num,occ);
% [~,id]=sort(occ)
% F=w(id,:)
A(:,1) = wrd;
A(:,2) = occ;
%A(:,2) = cellfun(@str2num,occ);

end