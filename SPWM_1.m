clc

Nf = 5000; %number of frames
fc = 500; %carrier frequency
fm = 50; %signal
MI = 0.7; %modulation index
theta = 0;

%time series
t=linspace(0,0.04,Nf);
ct = carr1(fc,t); %carrier time-domain signal
mt = m(MI,fm,0,t); %modulation function time series
ht = h(ct,mt); %pwm signal time series

writeobj = VideoWriter('SPWM','Uncompressed AVI');
open(writeobj);

fig1=figure('Renderer', 'painters', 'Position', [280 80 900 600]);
subplot(3,1,1);
title('Bipolar PWM Generation For H bridge');
subtitle('Developed by Dr.M.Kaliamoorthy')
set(gca,'XLim',[0 0.04], 'Ylim',[-0.25 1.25], 'Color','k');
curve=animatedline('LineWidth',2,'Color',"w");
curve0=animatedline('LineWidth',2,'Color',"c", 'Marker', '.', 'MarkerSize', 20);
curve2=animatedline('LineWidth',2,'Color',"w", 'Marker', '.', 'MarkerSize', 20);
curve1=animatedline('LineWidth',2,'Color',"c");

subplot(3,1,2)
title('Reference Wave > Carrier Wave');
subtitle('PWM For Leg One')
curve3=animatedline('LineWidth',2,'Color',"g");
set(gca,'XLim',[0 0.04], 'Ylim',[-0.25 1.25], 'Color','k');

    
subplot(3,1,3)
title('Carrier Wave > Reference Wave');
subtitle('PWM For Leg Two')
curve4=animatedline('LineWidth',2,'Color',"g");
set(gca,'XLim',[0 0.04], 'Ylim',[-0.25 1.25], 'Color','k');

for i=1:3:length(t)
    clearpoints(curve0)
    clearpoints(curve2)
    addpoints(curve,t(i),ct(i));
    addpoints(curve2,t(i),ct(i));
    addpoints(curve1,t(i),mt(i));
    addpoints(curve0,t(i),mt(i));
    addpoints(curve3,t(i),ht(i));
    addpoints(curve4,t(i),1-ht(i));
    drawnow
    currFrame=getframe(fig1);
    writeVideo(writeobj, currFrame)
   
end
close(writeobj)

%plot(t,ct)
%functions
function d= carr1(f,t) %carrier
   d = (1/pi)*acos(cos(2*pi*f*t));
end

function e= m(MI,f,theta,t) %modulation function
  e=(MI*sin(2*pi*f*t + theta) + 1)/2;
end

function f= h(ct,mt) %PWM switching function
  f=heaviside(mt-ct);
end

%parameters

