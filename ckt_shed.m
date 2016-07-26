%im1=imread('1.jpg');
close all
im1=imread('C:\Users\shubham\Desktop\image_dataset\binarised_image\img_jpg\37.jpg');
if(size(im1,3)==3)
    newim=rgb2gray(im1);
else
newim=im1;
end

result=load('C:\Users\shubham\Desktop\image_dataset\binarised_image\text_files\37.txt');
slopes=atan((result(:,2)-result(:,4))./(result(:,1)-result(:,3)));
lengths=sqrt((result(:,2)-result(:,4)).^2+(result(:,1)-result(:,3)).^2);
strai=(slopes >1.5) | (abs(slopes)<0.1) | (slopes<-1.5);
longs= lengths>20;
wires=strai & longs;
imshow(im1)
hold on 
med=median(median(newim))
for i=find(wires)'
    rect=result(i,1:4);
    if(abs(rect(1)-rect(3))>abs(rect(2)-rect(4)))
        p=3; %hz
    else
        p=4;    %vertical
    end
    flrect=floor([min(rect(2),rect(4)),min(rect(1),rect(3)),max(rect(2),rect(4)),max(rect(1),rect(3))]);
    flrect(p)=flrect(p)+5;
    flrect(p-2)=flrect(p-2)-3;
    if(p==3)
        rect=[min(rect(1),rect(3)), min(rect(2),rect(4)),abs(rect(1)-rect(3)),abs(rect(2)-rect(4))];
    else
        rect=[max(rect(1),rect(3)), min(rect(2),rect(4)),abs(rect(1)-rect(3)),abs(rect(2)-rect(4))];
    end
    rect( not(p-3)+3)=rect( not(p-3)+3)+5;
    newim(flrect(1):flrect(3),flrect(2):flrect(4))=med;
    rectangle('Position',rect,'EdgeColor','b');
end
figure,imshow(newim)