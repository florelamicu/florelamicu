% Write your code here
% This is the code for the 1st part
% Please check the code for the 2nd part
clear all
clc
close all
%% 1
load ('pcadata.mat');
%% 2
figure;
plot(X(:,1),X(:,2),'o');
hold on
xlim ([0  7]);
ylim ([2  8]);
%% 3
[mu,Xmu] = subtractMean(X);
%% 4
[U,S] = myPCA(Xmu);
%% 5
quiver(mu(1),mu(2),U(1,1),U(2,1),'color','red','LineWidth',2);
quiver(mu(1),mu(2),U(1,2),U(2,2),'color','green','LineWidth',2);
title("Datapoints and their 2 principal components")
%% 6
Z=projectData(Xmu,U,1);
%% 7
disp('Projection of First Three Points:')
disp(Z(1:3,:))
%% 8
Xrec = recoverData(Z,U,1,mu);
%% 9
figure;
plot(X(:,1),X(:,2),'o');
hold on
plot(Xrec(:,1),Xrec(:,2),'*','color','red');
hold on
xlim ([0  7]);
ylim ([2  8]);