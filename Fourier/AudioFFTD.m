clc;clear all;

%双声道计算量较大
%考虑到中央A为440Hz，音乐频率范围在80-1000Hz区间内,主频在500Hz以内
%根据奈圭斯特定理，为防止混叠，采样率应在2倍以上，设采样频率为1024Hz，方便计算
%由于性能限制，采样区间宽度固定0.01ms，参考价值可能较低
%绘制频谱图，实时显示和计算

%未完成
%分离高低频
%写出文件
% audiowrite('Output.wav',Audio+Audio1)


%打开音频文件，读取数据、比特率及参数信息
[Audio,Fs] = audioread('E:1.wav');
info = audioinfo('E:1.wav');
[Audio1,Fs1] = audioread('E:2.wav');
info = audioinfo('E:2.wav');

Audiobuf = zeros(Fs,2)

Audiobuf(1:Fs*30,1) = Audio(1:Fs*30,1)
Audiobuf(1:Fs*30,2) = Audio1(1:Fs*30,2)
 
 %

audiowrite('E:Output.wav',Audio(1:44100*60,1)+Audio1(1:44100*60,2),Fs)
audiowrite('E:Output1.wav',Audiobuf,Fs)
%播放音频
sound(Audio,Fs);
sound(Audio1,Fs1);
%设置样本数量和采样频率，算法自动补0
len = 441
get = 1024
%创建采样矩阵
Sample = zeros(len,2)
Sample1 = zeros(len,2)
%滚动偏置，记录当前位置
Off = 0;

%音频滚动
while Off < 44100*30
%设置区间
for current = Off + 1: 1 : Off+len
    Sample(current - Off,:) = Audio(current,:);
    Sample1(current - Off,:) = Audio1(current,:);
end
%根据区间进行傅里叶变换，提取频谱
Four = fft(Sample,get)
freq = (0:length(Four)-1)*(get/length(Four))
Four1 = fft(Sample1,get)
freq1 = (0:length(Four1)-1)*(get/length(Four1))
%调整，移出负频率
fshift = abs((-length(Four)/2:length(Four)/2-1)*(get/length(Four)))
yshift = fftshift(abs(Four));
fshift1 = abs((-length(Four1)/2:length(Four1)/2-1)*(get/length(Four1)))
yshift1 = fftshift(abs(Four1));
%显示图形
figure(1)
plot(fshift,yshift)
figure(2)
plot(fshift1,yshift1)
figure(3)
plot(fshift+fshift1,yshift+yshift1)
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
