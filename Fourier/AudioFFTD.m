clc;clear all;

%˫�����������ϴ�
%���ǵ�����AΪ440Hz������Ƶ�ʷ�Χ��80-1000Hz������,��Ƶ��500Hz����
%�����ι�˹�ض���Ϊ��ֹ�����������Ӧ��2�����ϣ������Ƶ��Ϊ1024Hz���������
%�����������ƣ����������ȹ̶�0.01ms���ο���ֵ���ܽϵ�
%����Ƶ��ͼ��ʵʱ��ʾ�ͼ���

%δ���
%����ߵ�Ƶ
%д���ļ�
% audiowrite('Output.wav',Audio+Audio1)


%����Ƶ�ļ�����ȡ���ݡ������ʼ�������Ϣ
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
%������Ƶ
sound(Audio,Fs);
sound(Audio1,Fs1);
%�������������Ͳ���Ƶ�ʣ��㷨�Զ���0
len = 441
get = 1024
%������������
Sample = zeros(len,2)
Sample1 = zeros(len,2)
%����ƫ�ã���¼��ǰλ��
Off = 0;

%��Ƶ����
while Off < 44100*30
%��������
for current = Off + 1: 1 : Off+len
    Sample(current - Off,:) = Audio(current,:);
    Sample1(current - Off,:) = Audio1(current,:);
end
%����������и���Ҷ�任����ȡƵ��
Four = fft(Sample,get)
freq = (0:length(Four)-1)*(get/length(Four))
Four1 = fft(Sample1,get)
freq1 = (0:length(Four1)-1)*(get/length(Four1))
%�������Ƴ���Ƶ��
fshift = abs((-length(Four)/2:length(Four)/2-1)*(get/length(Four)))
yshift = fftshift(abs(Four));
fshift1 = abs((-length(Four1)/2:length(Four1)/2-1)*(get/length(Four1)))
yshift1 = fftshift(abs(Four1));
%��ʾͼ��
figure(1)
plot(fshift,yshift)
figure(2)
plot(fshift1,yshift1)
figure(3)
plot(fshift+fshift1,yshift+yshift1)
hold off 
drawnow
%��������
Off = current;
end

%%%%%%%
%������ִ��ʱ��
tic;

toc;
% ���Ƴ���ִ��ʱ��
tic;
 for   timeout = 0.0001:0.0001:0.1
    while toc < timeout;
    end
 end
