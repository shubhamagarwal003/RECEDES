dire='C:\Users\shubham\Desktop\image_dataset\schematics\shedded_images\';
files_temp=dir(dire);
zbf = zernike_bf(100,25);
k=0;
size(files_temp)
for i=3:size(files_temp,1)
    if(~isequal(files_temp(i).name,'Thumbs.db'))
    temp=char(strcat(dire,files_temp(i).name,'\'));
    i
    files=dir(temp);
    data=zeros(150,1);
    for j=1:size(files,1)
%         files(j).name
        if(length(files(j).name)>3 && ~isequal(files(j).name,'Thumbs.db'))
            addr=strcat(temp,files(j).name);
            img=readtobin(addr);
            rsigni=rsign(img);
            zernike = zernike_mom(img,zbf);
            feat = zeros(363,1);
            feat(1:181)=rsigni;
            feat(182:end)=zernike;
            %%%find the cluster to which the image belongs and store the
            %%%result in n.
%             n=dist2(feat,kmeans_centroid);
            data(n)=data(n)+1;
        end
    end
    k=k+1;
    dataX(k,:)=data;
    end
end