%  directories where symbols and images are present
tic
circuit_images_symbols = 'C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\img_jpg_symbols\'; 
circuit_images = 'C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\img_jpg\';
non_circuit_images_symbols = 'C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\images_circuit_symbols\';
non_circuit_images = 'C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\images_circuit\';


circuit_images_dire = dir(circuit_images);
non_circuit_images_dire = dir(non_circuit_images);

featureX_HOG=zeros(30000, 4356);    % store hog features of every symbol
featureX_Radon=zeros(30000, 181);   % store rsign features of every symbol
featureX_Radon_norm=zeros(30000, 181);  % store normalised rsign features of every symbol
featureX_size = zeros(30000, 2);    % store ratio of symbol size with original image features of every symbol
% featureX=zeros(15000, 181); 

featureY=zeros(30000,1);
symbol_image_filename=repmat({''},30000,1);
image_filename=repmat({''},1000,1);

k=1;
l=1;
toc

tic
for i=1:size(circuit_images_dire,1)
    if(~(strcmp(circuit_images_dire(i).name,'.') == 1 | strcmp(circuit_images_dire(i).name,'..')==1 | strcmp(circuit_images_dire(i).name,'Thumbs.db') == 1))
        image_filename(l)=cellstr(strcat(circuit_images,circuit_images_dire(i).name));
        im_image = imread(strcat(circuit_images,circuit_images_dire(i).name));
        [m_image n_image]=size(im_image);
        a=strread(circuit_images_dire(i).name,'%s','delimiter','.');
        tempname=cell2mat(strcat(circuit_images_symbols,a(1),'\'));
        tempdir=dir(tempname);
        for j=1:size(tempdir,1)
           if(~(strcmp(tempdir(i).name,'.') == 1 | strcmp(tempdir(i).name,'..')==1 | strcmp(tempdir(i).name,'Thumbs.db') == 1))
                im_addr=strcat(tempname,tempdir(j).name);
                im_orig=imread(im_addr);
                im=scale(im_orig);
                im=(bwmorph(im,'remove'));
                featureX_HOG(k,:) = extractHOGFeatures(im, 'CellSize', [4 4]);
                featureX_Radon(k,:) = rsign(im);
                featureX_Radon_norm(k,:) = zscore(featureX_Radon(k,:));
                [m_sym n_sym]=size(im_orig);
                featureX_size(k,1) = m_sym/m_image;
                featureX_size(k,2) = n_sym/n_image;
                featureY(k)=l;
                symbol_image_filename(k)=cellstr(im_addr);
        %         featureX(k,:) = [a b];
        %         featureY(k,:) = str2num(elec_dire1(i).name);

        %         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
                k=k+1;
            end
        end
        l=l+1;
    end
end
toc

tic
for i=1:size(non_circuit_images_dire,1)
    if(~(strcmp(non_circuit_images_dire(i).name,'.') == 1 | strcmp(non_circuit_images_dire(i).name,'..')==1 | strcmp(non_circuit_images_dire(i).name,'Thumbs.db') == 1))
        image_filename(l)=cellstr(strcat(non_circuit_images,non_circuit_images_dire(i).name));
        im_image = imread(strcat(non_circuit_images,non_circuit_images_dire(i).name));
        [m_image n_image]=size(im_image);
        a=strread(non_circuit_images_dire(i).name,'%s','delimiter','.');
        tempname=cell2mat(strcat(non_circuit_images_symbols,a(1),'\'));
        tempdir=dir(tempname);
        for j=1:size(tempdir,1)
           if(~(strcmp(tempdir(i).name,'.') == 1 | strcmp(tempdir(i).name,'..')==1 | strcmp(tempdir(i).name,'Thumbs.db') == 1))
                im_addr=strcat(tempname,tempdir(j).name);
                im_orig=imread(im_addr);
                im=scale(im_orig);
                im=(bwmorph(im,'remove'));
                featureX_HOG(k,:) = extractHOGFeatures(im, 'CellSize', [4 4]);
                featureX_Radon(k,:) = rsign(im);
                featureX_Radon_norm(k,:) = zscore(featureX_Radon(k,:));
                [m_sym n_sym]=size(im_orig);
                featureX_size(k,1) = m_sym/m_image;
                featureX_size(k,2) = n_sym/n_image;
                featureY(k)=-1*l;
                symbol_image_filename(k)=cellstr(im_addr);
        %         featureX(k,:) = [a b];
        %         featureY(k,:) = str2num(elec_dire1(i).name);

        %         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
                k=k+1;
            end
        end
        l=l+1;
    end
end
toc
    




'XYOLO'
%   featureX=featureX(1:(k-1),:);
%   featureY=featureY(1:(k-1),:);
%   featureZ=featureZ(1:(k-1),:);