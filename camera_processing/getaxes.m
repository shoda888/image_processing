clear
load('stereoParams3.mat');
figure
depth = 'depth/0000000140.png';
im = imread(depth);
% 水平面
imshow(im*10)
hori = getrect;
% hori = uint16(hori);
close
% 垂直面
imshow(im*10)
vert = getrect;
% vert = uint16(vert);
close
% 原点
imshow(im*10)
[origin2d(1), origin2d(2)] = getpts;
% origin2d = uint16(origin2d);
close
cnt = 0;
for i = 1:hori(3)+1
    for j = 1:hori(4)+1
        cnt = cnt+1;
        horiDepth(1,cnt) = im(uint16(hori(2))+(j-1), uint16(hori(1))+(i-1));
        horiPixels(cnt,:) = [uint16(hori(1))+i-1, uint16(hori(2))+j-1, 1];
    end
end
cnt = 0;
for i = 1:vert(3)+1
    for j = 1:vert(4)+1
        cnt = cnt+1;
        vertDepth(1,cnt) = im(uint16(vert(2))+(j-1), uint16(vert(1))+(i-1));
        vertPixels(cnt,:) = [uint16(vert(1))+i-1, uint16(vert(2))+j-1, 1];
    end
end
origin2d(:,3) = 1;
v2intr = readmatrix("csv/v2Intr.csv");
origin = inv(v2intr') * origin2d' * cast(im(uint16(origin2d(:,2)), uint16(origin2d(:,1))), "double");
zplane = inv(v2intr') * double(horiPixels') .* cast(horiDepth, "double");
xplane = inv(v2intr') * double(vertPixels') .* cast(vertDepth, "double");
writematrix((zplane/1000)', "stair/Zplane.csv")
writematrix((xplane/1000)', "stair/Xplane.csv")
writematrix((origin/1000)', "stair/edge.csv")

% 確認用
% plot3(zplane(1,:), zplane(2,:), zplane(3,:),'o', xplane(1,:), xplane(2,:), xplane(3,:),'o', origin(1,:), origin(2,:), origin(3,:),'o')

% sf = fit([zplane(1,:)', zplane(2,:)'],zplane(3,:)','poly11');
% zaxis = [sf.p10, sf.p01, 1];
% sf = fit([xplane(1,:)', xplane(2,:)'],xplane(3,:)','poly11');
% xaxis = [sf.p10, sf.p01, 1];
% yaxis = cross(xaxis, zaxis);
% xaxis = cross(zaxis, yaxis);