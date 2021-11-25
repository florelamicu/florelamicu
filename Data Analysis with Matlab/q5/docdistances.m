% Write your code here

clc
clear all
close all
%% Calcualtion of Term frequency and nomincal term frequency
filename = "Cinderella.txt";
Cind = exttext(filename);
Cind = lower(Cind);
Cind_str_array = split(Cind);


filename = "RedRidingHood.txt";
Red = exttext(filename);
Red = lower(Red);
Red_str_array = split(Red);

filename = "PrincessPea.txt";
Pea = exttext(filename);
Pea = lower(Pea);
Pea_str_array = split(Pea);

filename = "CAFA1.txt";
C1 = exttext(filename);
C1 = lower(C1);
C1_str_array = split(C1);


filename = "CAFA2.txt";
C2 = exttext(filename);
C2 = lower(C2);
C2_str_array = split(C2);

filename = "CAFA3.txt";
C3 = exttext(filename);
C3 = lower(C3);
C3_str_array = split(C3);

%% calculation of inverse document frequency
%terms = [normalize_Cind(:,1);normalize_Red(:,1);normalize_Pea(:,1);normalize_C1(:,1);normalize_C2(:,1);normalize_C3(:,1)];
terms = [Cind_str_array;Red_str_array;Pea_str_array;C1_str_array;C2_str_array;C3_str_array];
[words_u, ~, idxU] = unique( terms );
%words_u = words_u(~isnan(words_u))';
len = length(words_u);
term_count = zeros(len,1);
for i=1:length(words_u)
    if ~any(strcmp(Cind_str_array,words_u(i)))
        words_u(i);
        term_count(i) = term_count(i)+1;
    end
end
Cind_term = term_count;
for i=1:length(words_u)
    if ~any(strcmp(Red_str_array,words_u(i)))
        words_u(i);
        term_count(i) = term_count(i)+1;
    end
end
Red_term = term_count-Cind_term;
for i=1:length(words_u)
    if ~any(strcmp(Pea_str_array,words_u(i)))
        words_u(i);
        term_count(i) = term_count(i)+1;
    end
end
Pea_term = term_count-Cind_term-Red_term;
for i=1:length(words_u)
    if ~any(strcmp(C1_str_array,words_u(i)))
        words_u(i);
        term_count(i) = term_count(i)+1;
    end
end

C1_term = term_count-Cind_term-Red_term-Pea_term;
for i=1:length(words_u)
    if ~any(strcmp(C2_str_array,words_u(i)))
        words_u(i);
        term_count(i) = term_count(i)+1;
    end
end
C2_term = term_count-Cind_term-Red_term-Pea_term-C1_term;
for i=1:length(words_u)
    if ~any(strcmp(C3_str_array,words_u(i)))
        words_u(i);
        term_count(i) = term_count(i)+1;
    end
end
C3_term = term_count-Cind_term-Red_term-Pea_term-C1_term-C2_term ;

for i=1:length(term_count)
    inv_doc_freq(i) = log10(6/term_count(i));
end
inv_doc_freq = inv_doc_freq';
%% id-idf vector  
Cind_v = inv_doc_freq.*Cind_term;
Red_v = inv_doc_freq.*Red_term;
Pea_v = inv_doc_freq.*Pea_term;
C1_v = inv_doc_freq.*C1_term;
C2_v = inv_doc_freq.*C2_term;
C3_v = inv_doc_freq.*C3_term;
C1_v(isnan(C1_v))=0;
C2_v(isnan(C2_v))=0;
C3_v(isnan(C3_v))=0;
Cind_v(isnan(Cind_v))=0;
Red_v(isnan(Red_v))=0;
Pea_v(isnan(Pea_v))=0;

%% Cosine distance between vectors
vec = [Cind_v,Red_v,Pea_v,C1_v,C2_v,C3_v];
for i=1:6
    for j=1:6
        CosTheta = max(min(dot(vec(:,j),vec(:,i))/(norm(vec(:,j))*norm(vec(:,i))),1),-1);
        dist(i,j) = 1-CosTheta;
    end
end
a = max(max(dist));
imagesc(dist./a)
colorbar
colormap('gray');





function textData = exttext(filename)
str = extractFileText(filename);
textData = split(str,newline);
end
