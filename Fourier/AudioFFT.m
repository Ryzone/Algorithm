clc;clear all;

%˫�����������ϴ�
%���ǵ�����AΪ440Hz������Ƶ�ʷ�Χ��80-1000Hz������,��Ƶ��500Hz����
%�����ι�˹�ض���Ϊ��ֹ�����������Ӧ��2�����ϣ������Ƶ��Ϊ1024Hz���������
%�����������ƣ����������ȹ̶�0.01ms���ο���ֵ���ܽϵ�
%����Ƶ��ͼ��ʵʱ��ʾ�ͼ���

%δ���
%����ߵ�Ƶ
%д���ļ�
% audiowrite('Output.wav',out)


%����Ƶ�ļ�����ȡ���ݡ������ʼ�������Ϣ
[Audio,Fs] = audioread('E:1.wav');
info = audioinfo('E:1.wav');

%������Ƶ
sound(Audio,Fs);

%�������������Ͳ���Ƶ�ʣ��㷨�Զ���0
len = 441
get = 1024
%������������
Sample = zeros(len,2)
%����ƫ�ã���¼��ǰλ��
Off = 0;

%��Ƶ����
while Off < length(Audio)
%��������
for current = Off + 1: 1 : Off+len
    Sample(current - Off,:) = Audio(current,:);
end
%����������и���Ҷ�任����ȡƵ��
Four = fft(Sample,get)
freq = (0:length(Four)-1)*(get/length(Four))
%�������Ƴ���Ƶ��
fshift = abs((-length(Four)/2:length(Four)/2-1)*(get/length(Four)))
yshift = fftshift(abs(Four));
%��ʾͼ��
plot(fshift,yshift)
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
