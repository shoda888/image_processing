% ç¿ïWïœä∑ñ≥Çµ ëOèàóùÇÃÇ›
load('stereoParams.mat');
AKraw = readmatrix('pos/v3/pos.csv');
v2boneData = readmatrix('pos/v2/pos.csv');
% AKboneData(:,1) = [];
% AKboneData(:,97) = [];
v2boneData(:,1:2) = [];

AKraw(:,2:3:95) = -AKraw(:,2:3:95);
v2boneData(:,1:3:73) = -v2boneData(:,1:3:73); %x?øΩ?øΩ?øΩ]
% v2boneData(:,2:3:74) = -v2boneData(:,2:3:74); %y?øΩ?øΩ?øΩ]

p = size(v2boneData, 1);
q = size(AKraw, 1);
AKboneData = resample(AKraw, p, q);
res = zeros(size(v2boneData));

AKboneData = AKboneData / 1000;

writematrix(v2boneData,"/Users/shoda/unity/KinectCSVLoader/Assets/Resources/v2.csv");
writematrix(AKboneData,"/Users/shoda/unity/KinectCSVLoader/Assets/Resources/v3.csv");







