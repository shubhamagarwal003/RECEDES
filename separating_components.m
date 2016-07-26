%This is the function for separating symbols. It takes three inputs original
%images and shedded image(after removal of connection lines) and image_filename. It saves the
%symbol images in a new directory whose name is same as the image_filename
function [box] = separating_components(original_im,shed_im,name)
if(~islogical(original_im)) 
    original_im=im2bw(original_im,graythresh(original_im));  %original circuit image
end
if(~islogical(original_im)) 
    shed_im=im2bw(shed_im,graythresh(shed_im));
end
inverted_im=imcomplement(shed_im);                       %invert of shedded image
labeledImage=bwlabel(inverted_im,8);
components = regionprops(labeledImage,shed_im, 'all');
numberOfComponents=size(components,1);
% box=zeros(numberOfComponents,4);
i=1;
[m n]=size(original_im);
for k=1:numberOfComponents
%     area[k]=components(k).Area;
    if(components(k).BoundingBox(3)>5 || components(k).BoundingBox(4)>5)
        new_box=components(k).BoundingBox;
        new_box(1)= max(new_box(1)-3,0);
        new_box(2)= max(new_box(2)-3,0);
        new_box(3)= min(new_box(3)+3,m);
        new_box(4)= min(new_box(4)+3,n);
        
        j=1;    
        a=1;
        while(j<i)
          if(sum(box(j,:))~=0 && new_box(1)>=box(j,1)-(new_box(3)+2) && new_box(2)>=box(j,2)-(new_box(4)+2) && new_box(1)<=box(j,1)+box(j,3)+2 && new_box(2)<=box(j,2)+box(j,4)+2)    % overlapping boxes are considered 
                a=0;
                x_new=min(box(j,1),new_box(1));
                y_new=min(box(j,2),new_box(2));
                w_x_new=max(abs(x_new-(box(j,1)+box(j,3))),abs(x_new-(new_box(1)+new_box(3))));
                w_y_new=max(abs(y_new-(box(j,2)+box(j,4))),abs(y_new-(new_box(2)+new_box(4))));
                new_box = [x_new y_new w_x_new w_y_new];
                box(j,:)=[0 0 0 0];
                j=0;
          end
          j=j+1;
        end
         box(i,:)=new_box;
         i=i+1;

    end
end

% figure;imshow(original_im);
% hold on;
box=box(find(box(:,3)~=0),:);
% mkdir(dire_symbols,name);
% file3=strcat(dire_symbols,name);
for k = 1 : size(box,1)
  thisBB = box(k,:);
  file2=cell2mat(strcat(name,num2str(k),'.jpg'));
  subImage = imcrop(original_im, box(k,:));                      %Here you can diretly calculate the features of symbols. I am saving them to a directory.
  imwrite(subImage,file2);                                  
%   rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','r','LineWidth',2 )
end
% box(:,3)=box(:,3)/m;
% hold off;
end