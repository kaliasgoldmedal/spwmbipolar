D = linspace(0, 200*360, 10000);
R = deg2rad(D);
Z = exp(R*1j) + exp((-2/3)*pi * R * 1j);
r=real(Z);
img = imag(Z);
writeobj = VideoWriter('Test2','Uncompressed AVI');
open(writeobj);
fig1=figure(1);
curve=animatedline('LineWidth',1, 'Color',"w");
set(gca,'XLim',[-2.5 2.5], 'Ylim',[-2.5 2.5], 'Color','k');

title('$$F(\theta)=e^{\theta i}+e^{\frac{-2}{3} \pi \theta i}$$-Developed by Dr.M.Kaliamoorthy','Interpreter','latex');
xlabel('Real part of F(\theta) ');
ylabel('Imaginary part of F(\theta)');
for i=1:length(D)
    addpoints(curve,r(i),img(i));
    drawnow
    currFrame=getframe(fig1);
    writeVideo(writeobj, currFrame)
   
end
close(writeobj)
