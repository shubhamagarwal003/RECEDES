% We've images with removed characters and text files which contains
% information of lines in the image. We finally need the separated symbols
% in the images. So the idea is remove line using ckt_lines you'll get
% shed_im. Using this shed_im and original_im separate the symbols and save
% them in a directory. Later instead of saving the symbols we can directly
% extract features from them.

dire_images_non_circuit = 'C:\Users\shubham\Desktop\BTP\segregated\non_circuit_pics_segregated\plus_remove\'; %This directory contains images with characters removed(non circuits).
dire_text_non_circuit = 'C:\Users\shubham\Desktop\BTP\segregated\non_circuit_pics_segregated\plus_remove_txt\'  ; %This directory contains text files with information of lines(non circuits).
dire_separate_components_non_circuit = 'C:\Users\shubham\Desktop\BTP\segregated\non_circuit_pics_segregated\symb\' ; %This is the directory where you want to save the symbols of an image(non circuits).
dire_images_circuit = 'C:\Users\shubham\Desktop\data\circuits\circuit_remove\'; %This directory contains images with characters removed(circuits).
dire_text_circuit = 'C:\Users\shubham\Desktop\data\circuits\circuit_text\'  ; %This directory contains text files with information of lines(circuits).
dire_separate_components_circuit = 'C:\Users\shubham\Desktop\data\circuits\symbols\' ; %This is the directory where you want to save the symbols of an image(circuits).
mkdir(dire_separate_components_non_circuit);
mkdir(dire_separate_components_circuit);
a2=dir(dire_images_circuit); 
a1=dir(dire_images_non_circuit); 
global visited;
global connect_new;
global loop;
for file_no=124:size(a2,1)
    tic;
    file_no
    if(~(strcmp(a2(file_no).name,'.') == 1 | strcmp(a2(file_no).name,'..')==1 | strcmp(a2(file_no).name,'Thumbs.db') == 1))
       file1=strcat(dire_images_circuit,a2(file_no).name);
       a=strread(a2(file_no).name,'%s','delimiter','.');
       original_im = imread(file1);
%        file3=strcat(dire_images_non_circuit,a2(i).name);
       file2=strcat(dire_text_circuit,a(1));
       file2=strcat(file2,'.txt');
       result=load(cell2mat(file2));
       if(~islogical(original_im))
        original_im=im2bw(original_im,graythresh(original_im));  %Binarised Image
       end
       im1= original_im;
       im1=(bwmorph(1-im1,'thin'));
       im1=1-im1;
       [shed_im,lines]=ckt_lines(im1,result);         %remove the lines from tthe image and return shedded image
%        figure;imshow(shed_im);
       name = strcat(dire_separate_components_circuit,a(1),'\');
       mkdir(cell2mat(name));
       box=separating_components(original_im,shed_im,name);   % separates the symbols and save them to a directory(determined by name).
       toc;
        tic;
        adjacency=zeros(size(box,1),size(box,1));
        abc=0;
        for i=1:size(box,1)-1
        % i=31;
            index=find((lines(:,1)>=box(i,1)-3 & lines(:,1)<=box(i,1)+box(i,3)+3 & lines(:,2)>=box(i,2)-3 & lines(:,2)<=box(i,2)+box(i,4)+3 & (lines(:,3)<=box(i,1)-3 | lines(:,3)>=box(i,1)+box(i,3)+3 | lines(:,4)<=box(i,2)-3 | lines(:,4)>=box(i,2)+box(i,4)+3)) | (lines(:,1)>=box(i,1)-3 & lines(:,1)<=box(i,1)+box(i,3)+3 & lines(:,4)>=box(i,2)-3 & lines(:,4)<=box(i,2)+box(i,4)+3 & (lines(:,3)<=box(i,1)-3 | lines(:,3)>=box(i,1)+box(i,3)+3 | lines(:,2)<=box(i,2)-3 | lines(:,2)>=box(i,2)+box(i,4)+3)) | (lines(:,3)>=box(i,1)-3 & lines(:,3)<=box(i,1)+box(i,3)+3 & lines(:,2)>=box(i,2)-3 & lines(:,2)<=box(i,2)+box(i,4)+3 & (lines(:,1)<=box(i,1)-3 | lines(:,1)>=box(i,1)+box(i,3)+3 | lines(:,4)<=box(i,2)-3 | lines(:,4)>=box(i,2)+box(i,4)+3)) | (lines(:,3)>=box(i,1)-3 & lines(:,3)<=box(i,1)+box(i,3)+3 & lines(:,4)>=box(i,2)-3 & lines(:,4)<=box(i,2)+box(i,4)+3 & (lines(:,1)<=box(i,1)-3 | lines(:,1)>=box(i,1)+box(i,3)+3 | lines(:,2)<=box(i,2)-3 | lines(:,2)>=box(i,2)+box(i,4)+3)));  %+3 is the offset
            for j=1:length(index)
                if ((lines(index(j),1)>=box(i,1)-3 && lines(index(j),1)<=box(i,1)+box(i,3)+3 && lines(index(j),2)>=box(i,2)-3 && lines(index(j),2)<=box(i,2)+box(i,4)+3))
                    connect=find((box(:,1)-3<=lines(index(j),3) & box(:,1)+box(:,3)+3>=lines(index(j),3) & box(:,2)-3<=lines(index(j),4) & box(:,2)+box(:,4)+3>=lines(index(j),4)));   % since lines(:,1) & lines(:,2) are inside one box the other should be inside some other box
                    mat=[1,2,3,4];                  % This indicates which end of the lines are in the box(first two coordinates)
                elseif ((lines(index(j),1)>=box(i,1)-3 && lines(index(j),1)<=box(i,1)+box(i,3)+3 && lines(index(j),4)>=box(i,2)-3 && lines(index(j),4)<=box(i,2)+box(i,4)+3))
                    connect=find((box(:,1)-3<=lines(index(j),3) & box(:,1)+box(:,3)+3>=lines(index(j),3) & box(:,2)-3<=lines(index(j),2) & box(:,2)+box(:,4)+3>=lines(index(j),2)));   % since lines(:,1) & lines(:,4) are inside one box the other should be inside some other box    
                    mat=[1,4,3,2];                  % This indicates which end of the lines are in the box
                elseif ((lines(index(j),3)>=box(i,1)-3 && lines(index(j),3)<=box(i,1)+box(i,3)+3 && lines(index(j),2)>=box(i,2)-3 && lines(index(j),2)<=box(i,2)+box(i,4)+3))
                    connect=find((box(:,1)-3<=lines(index(j),1) & box(:,1)+box(:,3)+3>=lines(index(j),1) & box(:,2)-3<=lines(index(j),4) & box(:,2)+box(:,4)+3>=lines(index(j),4)));   % since lines(:,1) & lines(:,2) are inside one box the other should be inside some other box
                    mat=[3,2,1,4];
                elseif ((lines(index(j),3)>=box(i,1)-3 && lines(index(j),3)<=box(i,1)+box(i,3)+3 && lines(index(j),4)>=box(i,2)-3 && lines(index(j),4)<=box(i,2)+box(i,4)+3))
                    connect=find((box(:,1)-3<=lines(index(j),1) & box(:,1)+box(:,3)+3>=lines(index(j),1) & box(:,2)-3<=lines(index(j),2) & box(:,2)+box(:,4)+3>=lines(index(j),2)));
                    mat=[3,4,1,2];
                end
                if(~isempty(connect))
                    for k=1:length(connect)
                        adjacency(i,connect(k))=1;
                        adjacency(connect(k),i)=1;
                    end
                    % need to do things in else
                else
%                     [i j]
                    flag=0;
                    line_index=index(j);
                    x_coordinate=max(floor(lines(line_index,mat(3))),1);
                    y_coordinate=max(floor(lines(line_index,mat(4))),1);
                    sign_x = (lines(line_index,mat(3))-lines(line_index,mat(1)));
                    sign_y = (lines(line_index,mat(4))-lines(line_index,mat(2)));
                    if(sign_x<=-1)
                        sign_x=-1;
                    elseif(sign_x>=1)
                        sign_x=1;
                    else
                        sign_x=0;
                    end
                    if(sign_y<=-1)
                        sign_y=-1;
                    elseif(sign_y>=1)
                        sign_y=1;
                    else
                        sign_y=0;
                    end
                    nearest=[];
                    [m n]=size(original_im);
                    visited=zeros(m,n);
                    connect_new=[];
                    if(original_im(y_coordinate,x_coordinate)~=0)
                        if(sign_y==0)
                            y_hat=max(1,y_coordinate-5):min(y_coordinate+5,m);
                            nearest=find(original_im(y_hat,x_coordinate)==0);
                        else
                            x_hat=max(1,x_coordinate-5):min(x_coordinate+5,n);
                            nearest=find(original_im(y_coordinate,x_hat)==0);
                        end
                    end
                    p=0;
                    if(~isempty(nearest))
                        if(sign_y==0)
                            y_coordinate=y_hat(nearest(1));
                        else
                            x_coordinate=x_hat(nearest(1));
                        end
                    end
%                         [sign_x sign_y x_coordinate y_coordinate]
                        loop=0;
                        dfs(original_im,x_coordinate,y_coordinate,sign_x,sign_y,box,i);
        %                 connect_new
                        if(~isempty(connect_new))
                            for k=1:length(connect_new)
                                adjacency(i,connect_new(k))=1;
                                adjacency(connect_new(k),i)=1;
                            end
                        else
                            abc=abc+1;
                        end

                end
            end
        end
    end
end
toc;