% This is the loop funcrion which is used for separating the symbols in
% images stored in a directory. It calls separating_component in every
% iteration.

dire='C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\CircuitLab_remove\';  %where images from which to extract symbols are present
dire_shed='C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\CircuitLab_shed\'; %where removed lines images are present
% dire_symbols='C:\Users\shubham\Desktop\segregated\non_circuit_pics_segregated\plus_symbols\';
% mkdir(dire_symbols);
a1=dir(dire);
% box=zeros(50000,4);
% k=1;
for i=3:size(a1,1)
       close all;
       i
       a1(i).name;
       file1=strcat(dire,a1(i).name);       
       a=strread(a1(i).name,'%s','delimiter','.');
       file2=strcat(dire_shed,a(1),'.jpg');      %where shedded images are present
       original_im=imread(file1);
       shed_im=imread(cell2mat(file2));
       name=a(1);       %name of the file 
       b=separating_components(original_im,shed_im,cell2mat(name));
       size_b=size(b,1);
       box(k:k+size_b-1,:)=b;
       k=k+size_b;
end