% v2 -> v3 ç¿ïWïœä∑
load('stereoParams.mat');
exnum = 9;
v2boneData = readmatrix("0331v2Data/" + exnum + "/pos/pos.csv");
AKraw = readmatrix("0331v3Data/" + exnum + "/0/pos.csv");
AKraw(:,1) = [];
AKraw(:,97) = [];
v2boneData(:,1:2) = [];

AKraw(:,2:3:95) = -AKraw(:,2:3:95);
v2boneData(:,1:3:73) = -v2boneData(:,1:3:73); %xîΩì]
% v2boneData(:,2:3:74) = -v2boneData(:,2:3:74); %yîΩì]

p = size(v2boneData, 1);
q = size(AKraw, 1);
AKboneData = resample(AKraw, p, q);
res = zeros(size(v2boneData));
v2boneData = v2boneData * 1000;

rotm = stereoParams.RotationOfCamera2;
tform = rotm2tform(rotm);
tform(1:3, 4) = stereoParams.TranslationOfCamera2;

for i = 1:3:size(v2boneData, 2)
    A = tform * [v2boneData(:,i:2+i)';ones(1,length(v2boneData(:,i:2+i)'))];
    A(4,:) = [];
    res(:,i:2+i) = A';
end

AKboneData = AKboneData / 1000;
res = res / 1000;

writematrix(res,"/Users/shoda/unity/KinectCSVLoader/Assets/Resources/"+ exnum + "v2.csv");
writematrix(AKboneData,"/Users/shoda/unity/KinectCSVLoader/Assets/Resources/"+ exnum + "v3.csv");



