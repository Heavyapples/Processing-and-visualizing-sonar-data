hexStr=fileread('声呐数据350new.txt');
HsvData=fileread('hsv256.txt');
HsvData2=str2num(HsvData);
HsvData3=reshape(HsvData2,[255,3]);
rgbData=hsv2rgb(HsvData3);

a=1;
new1Str=split(hexStr,' FE ');   %把每一帧分段
new2Str = eraseBetween(new1Str,"14","FD ",'Boundaries','inclusive');%清除14到fd的命令包
theta=185;
len1=length(new2Str);%计算数据长度

% 加载 colortrans.m
run('colortrans.m');

% 创建一个数组来存储最近画过的点的句柄
max_points = 360;
point_handles = gobjects(max_points, 1);

for i=1:1:len1
    new3Str=new2Str(i,:);%取每一帧的数据
    new3StrnoFC=split(new3Str);%把每一帧数据分成一个个数据点
    newData1=hex2dec(new3StrnoFC);

    number = (1:numel(new3StrnoFC))';

    len=length(new3StrnoFC);%计算每一帧非零数的个数

    rho=number;%把序数乘以量程得到极
    color=newData1;%颜色读取每一个数据的数据值，映射到rgb
    theta2=theta+0.45*i;% 角度每次步进0.45度
    theta_rad = repmat(deg2rad(theta2), len, 1);

    % 从 colortrans.m 的 colorCells2 中获取颜色
    ind = sub2ind(size(colorCells2), color+1, repmat(i, len, 1));
    color_cell = colorCells2(ind);
    color_mat = cell2mat(color_cell);

    for j = 1:len
        % 如果句柄数组已满，则删除最旧的点
        if ~isempty(point_handles(max_points)) && ishandle(point_handles(max_points))
            delete(point_handles(max_points));
        end

        % 绘制新点并将句柄保存到数组
        point_handles = [polarscatter(theta_rad(j),rho(j),1,'filled','MarkerFaceColor',color_mat(j,:)); point_handles(1:end-1)];
        hold on
    end
    rlim([0 200]);
    pause(0.0001);
end
hold on
