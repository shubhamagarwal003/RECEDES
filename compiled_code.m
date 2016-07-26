% We've images with removed characters and text files which contains
% information of lines in the image. We finally need the separated symbols
% in the images. So the idea is remove line using ckt_lines you'll get
% shed_im. Using this shed_im and original_im separate the symbols and save
% them in a directory. Later instead of saving the symbols we can directly
% extract features from them.

dire_images_non_circuit = 'C:\Users\shubham\Desktop\BTP\segregated\non_circuit_pics_segregated\plus_remove\'; %This directory contains images with characters removed(non circuits).
dire_text_non_circuit = 'C:\Users\shubham\Desktop\BTP\segregated\non_circuit_pics_segregated\plus_remove_txt\'  ; %This directory contains text files with information of lines(non circuits).
dire_separate_components_non_circuit = 'C:\Users\shubham\Desktop\BTP\segregated\non_circuit_pics_segregated\symb\' ; %This is the directory where you want to save the symbols of an image(non circuits).
dire_images_circuit = ''; %This directory contains images with characters removed(circuits).
dire_text_circuit = ''  ; %This directory contains text files with information of lines(circuits).
dire_separate_components_circuit = '' ; %This is the directory where you want to save the symbols of an image(circuits).
mkdir(dire_separate_components_non_circuit);
mkdir(dire_separate_components_non_circuit);
a1=dir(dire_images_circuit); 
a2=dir(dire_images_non_circuit); 
for i=1:size(a1,1)
    i
    if(~(strcmp(a1(i).name,'.') == 1 | strcmp(a1(i).name,'..')==1 | strcmp(a1(i).name,'Thumbs.db') == 1))
       file1=strcat(dire_images_circuit,a1(i).name);
       a=strread(a1(i).name,'%s','delimiter','.');
       original_im = imread(file1);
       im1= original_im;
       file3=strcat(dire_images_circuit,a1(i).name);
       file2=strcat(dire_text_circuit,a(1));
       file2=strcat(file2,'.txt');
       result=load(cell2mat(file2));
       if(~islogical(im1))
        im1=im2bw(im1,graythresh(im1));  %Binarised Image
       end
       im1=(bwmorph(1-im1,'remove'));
       im1=1-im1;
       [shed_im]=ckt_lines(im1,result);         %remove the lines from tthe image and return shedded image
       name = cell2mat(strcat(dire_separate_components_circuit,a(1),'\'));
       mkdir(name);
       separating_components(original_im,shed_im,name);   % separates the symbols and save them to a directory(determined by name).
    end
end

for i=1:size(a2,1)
    i
    if(~(strcmp(a2(i).name,'.') == 1 | strcmp(a2(i).name,'..')==1 | strcmp(a2(i).name,'Thumbs.db') == 1))
       file1=strcat(dire_images_non_circuit,a2(i).name);
       a=strread(a2(i).name,'%s','delimiter','.');
       original_im = imread(file1);
       im1= original_im;
       file3=strcat(dire_images_non_circuit,a2(i).name);
       file2=strcat(dire_text_non_circuit,a(1));
       file2=strcat(file2,'.txt');
       result=load(cell2mat(file2));
       if(~islogical(im1))
        im1=im2bw(im1,graythresh(im1));  %Binarised Image
       end
       im1=(bwmorph(1-im1,'remove'));
       im1=1-im1;
       [shed_im]=ckt_lines(im1,result);         %remove the lines from tthe image and return shedded image
       name = cell2mat(strcat(dire_separate_components_non_circuit,a(1),'\'));
       mkdir(name);
       separating_components(original_im,shed_im,name);   % separates the symbols and save them to a directory(determined by name).
    end
end