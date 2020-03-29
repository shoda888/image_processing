depth = imageDatastore(fullfile('depth'),...
'IncludeSubfolders',true,'FileExtensions','.png','LabelSource','foldernames');
imgs = readall(depth);
framenum = length(imgs);
height = 288;
width = 320;
mat3d = zeros(height, width, framenum);
itr = 100;

for i = 1:framenum
    mat3d(:,:,i) = imgs{i};
end

mat3d(mat3d == 0) = nan; %¹lðNaNÉu·
mat3d(mat3d > 8400) = nan; %ªèÍÍOðNaNÉu·
output = median(mat3d,3,'omitnan');
output(isnan(output)) = 0;
imwrite(imadjust(uint16(output)),'output1.png', 'BitDepth',16); %nñf[^Åâ®µ½depth}bv


for j = 1:itr
    m = 2 * round(j / 10) + 3;
    filtered = medfilt2(output, [m,m]);
    tmp = output;
    output(output == 0) = filtered(output == 0);
    if isequal(output, tmp)
        break
    end
    imwrite(imadjust(uint16(output)),append('depth_repaired/output',int2str(j+1),'.png'), 'BitDepth',16);
end