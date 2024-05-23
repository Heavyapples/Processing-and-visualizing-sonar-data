photo=imread('colorpicture.png');
% 读取色阶图片
% 转换为 RGB 图像
if size(photo, 3) == 1
    photo = gray2rgb(photo);
end

% 缩放到 255 x 1
photo = imresize(photo, [255 1]);

% 将图像转换为颜色矩阵
colorValues = double(reshape(photo, [], 3)) / 255;

% 初始化 colorCells2 变量
colorCells2 = cell(255, len1);

% 将颜色数据填充到 colorCells2
for i = 1:size(colorValues, 1)
    for j = 1:len1
        hexStr = colorValues(i, :);
        colorCells2{i, j} = hexStr;
    end
end
