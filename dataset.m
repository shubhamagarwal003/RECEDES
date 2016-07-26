file3=strcat('C:\Users\shubham\Desktop\image_dataset\schematics\shedded_images_new\';
d = dir(file3);
k=0;
file_nc='C:\Users\shubham\Desktop\image_dataset\non_circuit\';
for i=3:size(dir,1)
    file=strcat(file3,d(i).name);
    d_temp=dir(file);
    for j=1:floor(size(d_temp,1)/10)
        a=randi([3,size(d_temp,1)-1],1,1);
        addr=strcat(file,'\',d_temp(a).name);
        im=imread(addr);
        [m n]=size(im);
        if(m>20 | n>20)
            k=k+1;
            f=strcat(file_nc,num2str(k));
            imwrite(im,f);
        end
    end
end