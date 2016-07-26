function img=readtobin(I)
    img=scale(imread(I));
%img=imrotate(img,90);
% img=im2bw(img,graythresh(img));
% if(median(median(img))==0)
%     img=(bwmorph(img,'remove'));
% else
%     img=(bwmorph(1-img,'remove'));
% end
% imshow(img);
end
