clc
clear all
close all

%初值

Target = 500;
error(30) = 0;
Derror(30) = 0;
Ierror(30) = 0;
Now(30) = 0;
x = 1;
% PID 对应的预设的K值%
Kp = 0.5;
Ki = 0.005;
Kd = 0.01;

% x = 1:30;
% y = 1:30;
% plot(x,y)

LastError = 0;
Last2Error = 0;
while(x<=30)
error(x) = Target - Now(x);

Ierror(x) = error(x) + LastError;

Derror(x) = LastError - Last2Error + error(x) - Last2Error;

Now(x+1) = Now(x) + (error(x) * Kp + Ierror(x) * Ki + Derror(x) * Kd)*0.3;

Last2Error = LastError;
LastError = error(x);
%error = P_I_D(error);
x = x+1;

Target = Target + 5;
Now(x+1) = Now(x)+5
% linspace
% spline

% plot(x,Now,'o',x,error,'o',x,Derror,'o',x,Ierror,'o');
% hold on;
end

plot(Now)
hold on
plot(error*Kp)
hold on 
plot(Derror)
hold on
plot(Ierror);
% x = 1:30;

% plot(1,1,'o')
clc;

function [M] = P_I_D(N)
% error = error+1;
M = N + 1;

end



