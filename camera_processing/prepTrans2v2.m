% v3 -> v2 ���W�ϊ�
load('stereoParams3.mat');
exnum = 15;
v2boneData = readmatrix("0331v2Data/" + exnum + "/pos/pos.csv");
AKraw = readmatrix("0331v3Data/" + exnum + "/0/pos.csv");
AKraw(:,1) = [];
AKraw(:,97) = [];
v2boneData(:,1:2) = [];

AKraw(:,2:3:95) = -AKraw(:,2:3:95);
v2boneData(:,1:3:73) = -v2boneData(:,1:3:73); %x���]
% v2boneData(:,2:3:74) = -v2boneData(:,2:3:74); %y���]

p = size(v2boneData, 1);
q = size(AKraw, 1);
AKboneData = resample(AKraw, p, q);
res = zeros(size(AKboneData));

% streoParams3 or stereoParams2
rotm = stereoParams3.RotationOfCamera2;
tform = rotm2tform(rotm);
tform(1:3, 4) = stereoParams3.TranslationOfCamera2;

for i = 1:3:size(AKboneData, 2)
    A = tform * [AKboneData(:,i:2+i)';ones(1,length(AKboneData(:,i:2+i)'))];
    A(4,:) = [];
    res(:,i:2+i) = A';
end

res = res / 1000;

% v2���W�n
writematrix(res,"/Users/shoda/unity/KinectCSVLoader/Assets/Resources/"+ exnum + "ver3.csv");
writematrix(v2boneData,"/Users/shoda/unity/KinectCSVLoader/Assets/Resources/"+ exnum + "ver2.csv");
writematrix(res, exnum + "ver3.csv");
writematrix(v2boneData, exnum + "ver2.csv");

