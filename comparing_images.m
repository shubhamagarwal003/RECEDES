a1=dir('C:\Users\shubham\Desktop\image_dataset\symbols\g');
data_files=repmat({''},size(a1,1),4);
fid = fopen('list.txt','w');
j=1;
for i=3:size(a1,1)
    file=strcat('C:\Users\shubham\Desktop\image_dataset\symbols\g\',a1(i).name);
    i
    a1(i).name
    im=imread(file);
%     im1=imrotate(im,90);    
    if(max(max(im))==1)
        im=im*255;
    end
    hg1=fspecial('gaussian',[3 3],1.5);
    hg2=fspecial('gaussian',[5 5],1.5);
    hg3=fspecial('gaussian',[7 7],1.5);
    hg4=fspecial('gaussian',[9 9],1.5);
    im1=uint8(conv2(double(im),hg1,'same'));
    im2=uint8(conv2(double(im),hg2,'same'));
    im3=uint8(conv2(double(im),hg3,'same'));
    im4=uint8(conv2(double(im),hg4,'same'));
% %     [m n]
    fprintf(fid,a1(i).name);
    fprintf(fid,',');
    fprintf(fid,num2str(sum(im(1,:))));
    fprintf(fid,',');
    fprintf(fid,num2str(size(im,1)));
    fprintf(fid,',');
    fprintf(fid,num2str(size(im,2)));
    fprintf(fid,'\n');
    a=strread(a1(i).name,'%s','delimiter','.');
    file2=strcat('C:\Users\shubham\Desktop\image_dataset\symbols\g1\',num2str(j));
    j=j+1;
    file3=strcat('C:\Users\shubham\Desktop\image_dataset\symbols\g1\',num2str(j));
    j=j+1;
    file4=strcat('C:\Users\shubham\Desktop\image_dataset\symbols\g1\',num2str(j));
    j=j+1;
    file5=strcat('C:\Users\shubham\Desktop\image_dataset\symbols\g1\',num2str(j));
    j=j+1;
    file6=strcat('C:\Users\shubham\Desktop\image_dataset\symbols\g1\',num2str(j));
    j=j+1;
    a2=strcat('.',a(2));
    file2=strcat(file2,a2);
    file3=strcat(file3,a2);
    file4=strcat(file4,a2);
    file5=strcat(file5,a2);
    file6=strcat(file6,a2);
    imwrite(im,cell2mat(file2));
    imwrite(im1,cell2mat(file3));
    imwrite(im2,cell2mat(file4));
    imwrite(im3,cell2mat(file5));
    imwrite(im4,cell2mat(file6));
%     data_files(i,1)=cellstr(num2str(i-2));
%     data_files(i,2)=num2cell(sum(im(1,:)));
%     data_files(i,3)=num2cell(size(im,1));
%     data_files(i,4)=num2cell(size(im,2));
end
% for i=1:size(data_files,1)
%     b=1;
%     for j=1:size(data_files,1)
%         if(i>j && cell2mat(data_files(i,2))==cell2mat(data_files(j,2)) && cell2mat(data_files(i,3))==cell2mat(data_files(j,3)) && cell2mat(data_files(i,4))==cell2mat(data_files(j,4)))
%             b=0;
%             break;
%         end
%     end
%     if(b==0)
%          data_files(i,1)
%          data_files(j,1)
%          
% %        file1=strcat('C:\Users\shubham\Desktop\New folder (2)\',cell2mat(data_files(i,1)));
% %        file2=strcat('C:\Users\shubham\Desktop\New folder (3)\');
% %        copyfile(file1,file2);
% %     else
% %         i
%     end
% end
    
    