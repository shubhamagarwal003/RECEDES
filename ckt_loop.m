% This is the loop funcrion which is used for removing connection lines
% from images stored in a directory. It calls ckt_lines in every
% iteration.
dire='C:\Users\shubham\Desktop\segregated\non_circuit_pics_segregated\plus_remove\';   %directory where images are present
dire_shed='C:\Users\shubham\Desktop\segregated\non_circuit_pics_segregated\plus_remove_shed\';  %directory where images are to be saved
dire_txt='C:\Users\shubham\Desktop\segregated\non_circuit_pics_segregated\plus_remove_txt\';     % directory where txt files are present which contains the LSD output
mkdir(dire_shed)
a1=dir(dire); 
% i=7;
for i=3:size(a1,1)
       i
%        if(i~=7)
       a1(i).name
       file1=strcat(dire,a1(i).name);
       a=strread(a1(i).name,'%s','delimiter','.');
       im1=imread(file1);
%        if(max(max(im1))==1)
%            im1=255*im1;
%        end
%        if(length(size(im))==3)
%            im=rgb2gray(im);
%        end
       file3=strcat(dire_shed,a1(i).name);
       file2=strcat(dire_txt,a(1));
       file2=strcat(file2,'.txt');
       result=load(cell2mat(file2));
       if(max(max(im1))~=1)
        im1=im2bw(im1,graythresh(im1));  %Binarised Image
       end
       im1=(bwmorph(1-im1,'remove'));
       im1=1-im1;
       [newim]=ckt_lines(im1,result);
       imwrite(newim,file3);
       clear result;
       clear newim;
       clear im1;
end