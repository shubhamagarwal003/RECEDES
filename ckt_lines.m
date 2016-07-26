%Function to remove lines in an image. Parameters are original image and
%the lines detected. Output is new image.
function [newim,connection_lines] = ckt_lines(im1,result)
close all;
% im1=imread('C:\Users\shubham\Desktop\image_dataset\binarised_image\img_jpg\117.jpg');
[m n]=size(im1);
if(size(im1,3)==3)
    newim=rgb2gray(im1);
else
newim=im1;
end 
% result=load('C:\Users\shubham\Desktop\image_dataset\binarised_image\text_files\117.txt');
slopes=atan((result(:,2)-result(:,4))./(result(:,1)-result(:,3)));
lengths=sqrt((result(:,2)-result(:,4)).^2+(result(:,1)-result(:,3)).^2);
strai_hori=(abs(slopes)<0.1);
strai_vert=(abs(slopes)>1.5);
j=1;
k=1;
l_h=lengths(find(strai_hori));
l_v=lengths(find(strai_vert));
% for i=1:size(result,1)
%     if(strai_hori(i)==1)
%         l_h(j)=lengths(i);
%         j=j+1;
%     end
%     if(strai_vert(i)==1)
%         l_v(k)=lengths(i);
%         k=k+1;
%     end
% end
% a=mean(l_h)-std(l_h);
% b=mean(l_v)-std(l_v);
a=2;
b=2;
longs_hor=lengths>a;
longs_ver=lengths>b;
wires_hor=strai_hori & longs_hor;
wires_vert=strai_vert & longs_ver;
wires=wires_hor | wires_vert;
med=1;   %Since the image is logical
% imshow(newim);
% hold on;
connection_lines=zeros(sum(wires==1),5);
for i=find(wires)'
    rect=result(i,1:4);
    connection_lines(j,1:4)=result(i,1:4);
    if(abs(rect(1)-rect(3))>abs(rect(2)-rect(4)))
        p=3; %hz
    else
        p=4;    %vertical
    end
    connection_lines(j,5)=p;
    j=j+1;
    flrect=floor([min(rect(2),rect(4)),min(rect(1),rect(3)),max(rect(2),rect(4)),max(rect(1),rect(3))]);
    if(p==3)
        flrect(p)=flrect(p)+2;
        flrect(p-2)=flrect(p)-2;
%         flrect(4)=flrect(4)+5;
%         flrect(2)=flrect(2)-5;
%     else
%         flrect(p)=m;
% %         flrect(p-2)=flrect(p-2);
    end
    if(p==4)
        flrect(p)=flrect(p)+2;
        flrect(p-2)=flrect(p)-2;
%         flrect(3)=flrect(3)+5;
%         flrect(1)=flrect(1)-5;
%     else
%         flrect(p)=n;
% %         flrect(p-2)=flrect(p-2);
    end
    if(flrect(3)>m)
        flrect(3)=m;
    end
    if(flrect(4)>n)
        flrect(4)=n;
    end
    if(flrect(1)<1)
        flrect(1)=1;
    end
    if(flrect(2)<1)
        flrect(2)=1;
    end
    if(p==3)
        rect=[min(rect(1),rect(3)), min(rect(2),rect(4)),abs(rect(1)-rect(3)),abs(rect(2)-rect(4))];
%         flrect=[min(flrect(1),flrect(3)), min(flrect(2),flrect(4)),abs(flrect(1)-flrect(3)),abs(flrect(2)-flrect(4))];
    else
        rect=[max(rect(1),rect(3)), min(rect(2),rect(4)),abs(rect(1)-rect(3)),abs(rect(2)-rect(4))];
%         flrect=[max(flrect(1),flrect(3)), min(flrect(2),flrect(4)),abs(flrect(1)-flrect(3)),abs(flrect(2)-flrect(4))];
    end 
    rect( not(p-3)+3)=rect( not(p-3)+3)+1;
%     flrect( not(p-3)+3)=flrect( not(p-3)+3)+1;
    newim(flrect(1):flrect(3),flrect(2):flrect(4))=med;
%     rectangle('Position',rect,'EdgeColor','b');
end
% figure,imshow(newim)
end