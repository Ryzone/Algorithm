clc;clear all;

%双声道计算量较大
%考虑到中央A为440Hz，音乐频率范围在80-1000Hz区间内,主频在500Hz以内
%根据奈圭斯特定理，为防止混叠，采样率应在2倍以上，设采样频率为1024Hz，方便计算
%由于性能限制，采样区间宽度固定0.01ms，参考价值可能较低
%绘制频谱图，实时显示和计算

%未完成
%分离高低频
%写出文件
% audiowrite('Output.wav',out)


%打开音频文件，读取数据、比特率及参数信息
[Audio,Fs] = audioread('E:1.wav');
info = audioinfo('E:1.wav');

%播放音频
sound(Audio,Fs);

%设置样本数量和采样频率，算法自动补0
len = 441
get = 1024
%创建采样矩阵
Sample = zeros(len,2)
%滚动偏置，记录当前位置
Off = 0;

%音频滚动
while Off < length(Audio)
%设置区间
for current = Off + 1: 1 : Off+len
    Sample(current - Off,:) = Audio(current,:);
end
%根据区间进行傅里叶变换，提取频谱
Four = fft(Sample,get)
freq = (0:length(Four)-1)*(get/length(Four))
%调整，移出负频率
fshift = abs((-length(Four)/2:length(Four)/2-1)*(get/length(Four)))
yshift = fftshift(abs(Four));
%显示图形
plot(fshift,yshift)
hold off 
drawnow
%更新区间
Off = current;
end

%%%%%%%
%检测程序执行时间
tic;

toc;
% 控制程序执行时间
tic;
 for   timeout = 0.0001:0.0001:0.1
    while toc < timeout;
    end
 end
