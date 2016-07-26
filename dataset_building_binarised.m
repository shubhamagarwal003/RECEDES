dire='C:\Users\shubham\Desktop\symb\_dataset\';
dire2='C:\Users\shubham\Desktop\symb\_dataset_sep\';
d1=dir(dire);
l=0;
for i=1:size(d1,1)
    if(~(strcmp(d1(i).name,'.') == 1 | strcmp(d1(i).name,'..') == 1))
        temp=strcat(dire,d1(i).name,'\');
        name=strcat(dire2,d1(i).name,'\');
        mkdir(name);
        temp_d = dir(temp); 
        number=1;
        for j=1:size(temp_d,1)
            if(~(strcmp(temp_d(j).name,'.') == 1 | strcmp(temp_d(j).name,'..')==1 | strcmp(temp_d(j).name,'Thumbs.db') == 1))
%                 a=strread(temp_d(j).name,'%s','delimiter','.');
                original_im=imread(strcat(temp,temp_d(j).name));
                number = separating_components(original_im,original_im,name,number);
%                 imwrite(original_im,cell2mat(strcat(temp_copy,num2str(j),'.',a(2))));
            end
         end
    end
end