function Rsign=rsign(I)
% figure,
% iptsetpref('ImshowAxesVisible','on')
 theta = 0:180;
[R,xp] = radon(I,theta);
% imshow(R,[],'Xdata',theta,'Ydata',xp,'InitialMagnification','fit')
% xlabel('\theta (degrees)')
% ylabel('x''')
% colormap(hot), colorbar
% iptsetpref('ImshowAxesVisible','off')


Rsign=sum(R.*R,1);
% figure,plot(Rsign)