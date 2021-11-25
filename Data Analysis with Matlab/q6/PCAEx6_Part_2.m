% 2nd Part

clear all
clc
close all
%% 1
load ('pcafaces.mat');
%% 2
figure;
displayData(X(1:100, :))
%% 3
[mu,Xmu] = subtractMean(X);
%% 4
[U,S] = myPCA(Xmu);
Z=projectData(Xmu,U,200);
%% 5
Xrec = recoverData(Z,U,200,mu);
%% 6
figure;
subplot(1,2,1)
displayData(X(1:100, :))
title('Original Faces')
hold on
subplot(1,2,2)
displayData(Xrec(1:100, :))
title('Recovered Faces')