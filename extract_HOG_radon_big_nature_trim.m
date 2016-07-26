%  directories where symbols and images are present
tic
elec1='C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\img_jpg_symbols\'; 
elec1_images = 'C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\img_jpg\';
elec2='C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\images_circuit_symbols\';
elec2_images = 'C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\images_circuit\';
elec3='C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\CircuitLab_symbols\';
elec3_images ='C:\Users\shubham\Desktop\image_dataset\binarised_image_new\NEW\CircuitLab_85\';
sch1='C:\Users\shubham\Desktop\segregated\non_circuit_pics_segregated\plus_symbols\';
sch1_images = 'C:\Users\shubham\Desktop\segregated\non_circuit_pics_segregated\plus\';


elec_dire1_images=dir(elec1_images);
elec_dire2_images=dir(elec2_images);
% elec_dire3=dir(elec3);
elec_dire3_images=dir(elec3_images);
% sch_dire1=dir(sch1);
sch_dire1_images=dir(sch1_images);
% norm_dire2=dir(sch2);
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
for i=4:size(elec_dire1_images,1)
    image_filename(l)=cellstr(strcat(elec1_images,elec_dire1_images(i).name));
    im_image = imread(strcat(elec1_images,elec_dire1_images(i).name));
    [m_image n_image]=size(im_image);
    a=strread(elec_dire1_images(i).name,'%s','delimiter','.');
    tempname=cell2mat(strcat(elec1,a(1),'\'));
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
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
    l=l+1;
end
toc

'XOLO'
tic
for i=4:size(elec_dire2_images,1)
    image_filename(l)=cellstr(strcat(elec2_images,elec_dire2_images(i).name));
    im_image = imread(strcat(elec2_images,elec_dire2_images(i).name));
    [m_image n_image]=size(im_image);
    a=strread(elec_dire2_images(i).name,'%s','delimiter','.');
    tempname=cell2mat(strcat(elec2,a(1),'\'));
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
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
        k=k+1;
    end
    l=l+1;
end 
'YOLO'
toc


tic
for i=4:size(elec_dire3_images,1)
    image_filename(l)=cellstr(strcat(elec3_images,elec_dire3_images(i).name));
    im_image = imread(strcat(elec3_images,elec_dire3_images(i).name));
    [m_image n_image]=size(im_image);
    a=strread(elec_dire3_images(i).name,'%s','delimiter','.');
    tempname=cell2mat(strcat(elec3,a(1),'\'));
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
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
    l=l+1;
end 
toc


'ZOLO'

%non_circuits
% y_count=1000;
% prev_j=100000;
tic
for i=4:size(sch_dire1_images,1)
    image_filename(l)=cellstr(strcat(sch1_images,sch_dire1_images(i).name));
    im_image = imread(strcat(sch1_images,sch_dire1_images(i).name));
    if(manmadeCheck(model, minimums, ranges, strcat(sch1_images,sch_dire1_images(i).name))>0)
        [m_image n_image]=size(im_image);
        a=strread(sch_dire1_images(i).name,'%s','delimiter','.');
        tempname=cell2mat(strcat(sch1,a(1),'\'));
        tempdir=dir(tempname);
        for j=4:size(tempdir,1)
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
        l=l+1;
    end
% end
toc
    




'XYOLO'
%   featureX=featureX(1:(k-1),:);
%   featureY=featureY(1:(k-1),:);
%   featureZ=featureZ(1:(k-1),:);