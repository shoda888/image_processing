load('stereoParams.mat');
AKboneData = readmatrix('test.csv');
AKboneData(:,1) = [];
res = zeros(size(AKboneData));

rotm = stereoParams.RotationOfCamera2;
tform = rotm2tform(rotm);
tform(1:3, 4) = stereoParams.TranslationOfCamera2;

for i = 1:3:length(AKboneData)
    A = tform * [AKboneData(:,i:2+i)';ones(1,length(AKboneData(:,i:2+i)'))];
    A(4,:) = [];
    res(:,i:2+i) = A';
end



