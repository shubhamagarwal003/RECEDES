% dire = 'C:\Users\shubham\Desktop\pneumatic_diagrams\';
dire = 'C:\Users\shubham\Desktop\p\';
a1=dir(dire);
% data_files=repmat({''},size(a1,1),4);
% fid = fopen('list.txt','w');
% j=63;
% for i=3:size(a1,1)
%     file=strcat(dire,a1(i).name);
%     im=imread(file);
% %     i
% % %     if(length(size(im))==3)
% % %         im=rgb2gray(im);
% % %     end
%     if(length(class(im))~=7)
%         im=im2bw(im,graythresh(im));
%     end
% % %     im=(imcomplement(bwmorph(1-im,'thin',Inf)));
% % %     a=strread(a1(i).name,'%s','delimiter','.');
% % %     a2=strcat(num2str(i-2),'.jpg');
% % %     file2=strcat(dire2,a2);
% % %     imwrite(im,file2);
% % %     a2=strcat(a(1),'.pgm');
% % %     a3=strcat(a(1),'.jpg');
% % %        file2=strcat(dire,'pgm\',a2);
% % %        file3=strcat(dire,'jpg\',a3);
% % %     file2=strcat(file2,a2);
% % %     file3=strcat(file3,a2);
% % %     imwrite(im,cell2mat(file2));
% % %     imwrite(im,cell2mat(file3));
%     data_files(i-2,1)=cellstr(a1(i).name);
%     data_files(i-2,2)=num2cell(sum(im(1,:)));
%     data_files(i-2,3)=num2cell(size(im,1));
%     data_files(i-2,4)=num2cell(size(im,2));
%     end
% end
for i=1:length(data_files)
    for j=i+1:length(data_files)
        if(cell2mat(data_files(i,2))==cell2mat(data_files(j,2)) && cell2mat(data_files(i,3))==cell2mat(data_files(j,3)) && cell2mat(data_files(i,4))==cell2mat(data_files(j,4)));
            fprintf('i=%s j=%s \n',cell2mat(data_files(i,1)),cell2mat(data_files(j,1)))
            delete(strcat(dire,cell2mat(data_files(j,1))));
        end
    end
end
%        i-2
%        a1(i).name
%        file1=strcat('C:\Users\shubham\Desktop\image_dataset\binarised_image\img_jpg\',a1(i).name);
% %        a=strread(a1(i).name,'%s','delimiter','.')
%        im=imread(file1);
%        if(length(size(im))==3)
%            im=rgb2gray(im);
%        end
%        im=im2bw(im,graythresh(im));
% %        file3=strcat('C:\Users\shubham\Desktop\image_dataset\img_jpg\',a(1));
% %        file2=strcat('C:\Users\shubham\Desktop\image_dataset\img_pgm\',a(1));
% %        file2=strcat(file2,'.pgm');
% %        file3=strcat(file3,'.jpg');
% %        imwrite(im,cell2mat(file3));
%         file1=strcat('C:\Users\shubham\Desktop\image_dataset\binarised_image\img_jpg1\',a1(i).name);
%         imwrite(im,file1);

%     
    