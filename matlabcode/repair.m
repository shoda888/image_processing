depth = imageDatastore(fullfile('sample'),...
'IncludeSubfolders',true,'FileExtensions','.tiff','LabelSource','foldernames');
imgs = readall(depth);
framenum = length(imgs);
height = 424;
width = 512;
mat3d = zeros(height, width, framenum);
itr = 20;

for i = 1:framenum
    mat3d(:,:,i) = imgs{i};
end

mat3d(mat3d == 0) = nan; %欠損値をNaNに置換
mat3d(mat3d > 8400) = nan; %測定範囲外をNaNに置換
output = median(mat3d,3,'omitnan');
output(isnan(output)) = 0;
imwrite(imadjust(uint16(output)),'sample/output1.png', 'BitDepth',16); %時系列データで補完したdepthマップ


for j = 1:itr
    m = 2 * round(j / 10) + 3;
    filtered = medfilt2(output, [m,m]);
    tmp = output;
    output(output == 0) = filtered(output == 0);
    if isequal(output, tmp)
        break
    end
    imwrite(imadjust(uint16(output)),append('sample/output',int2str(j+1),'.png'), 'BitDepth',16);
end