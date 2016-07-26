%  name1='/Users/mohit/Desktop/btp_code/unsupervised/CircuitLab_symbols/';
elec1='/Users/mohit/Desktop/btp_code/unsupervised/img_jpg/img_jpg_symbols/';
elec2='/Users/mohit/Desktop/btp_code/unsupervised/images_circuit_symbols/';
elec3='/Users/mohit/Desktop/btp_code/unsupervised/CircuitLab_symbols/';
sch1='/Users/mohit/Desktop/btp_code/unsupervised/non_circuits/plus_symbols/';
sch2='/Users/mohit/Desktop/btp_code/unsupervised/schematics_symbols/';

% dire1=dir(name1);
elec_dire1=dir(elec1);
elec_dire2=dir(elec2);
elec_dire3=dir(elec3);
norm_dire1=dir(sch1);
norm_dire2=dir(sch2);
featureX=zeros(30000, 4537); 
% featureX=zeros(15000, 181); 

featureY=zeros(30000,1);
k=1;
% for i=4:size(dire1,1)
%     tempname=strcat(name1, dire1(i).name,'/');
%     tempdir=dir(tempname);
%     for j=4:size(tempdir,1)
%         im=scale(imread(strcat(tempname,tempdir(j).name)));
%         im=(bwmorph(im,'remove'));
%         a = extractHOGFeatures(im, 'CellSize', [4 4]);
%         b = zscore(rsign(im));
%         featureX(k,:) = [a b];
%         featureY(k,:) = double(str2num(dire1(i).name));
%         k=k+1;
%     end
% end
featureZ=zeros(30000,1);
for i=4:size(elec_dire1,1)
    tempname=strcat(elec1, elec_dire1(i).name,'/');
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
        im=scale(imread(strcat(tempname,tempdir(j).name)));
        im=(bwmorph(im,'remove'));
        a = extractHOGFeatures(im, 'CellSize', [4 4]);
        b = zscore(rsign(im));
        featureX(k,:) = [a b];
        featureY(k,:) = str2num(elec_dire1(i).name);
%         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
        k=k+1;
    end
end 
'XOLO'
for i=4:size(elec_dire2,1)
    tempname=strcat(elec2, elec_dire2(i).name,'/');
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
        im=scale(imread(strcat(tempname,tempdir(j).name)));
        im=(bwmorph(im,'remove'));
        a = extractHOGFeatures(im, 'CellSize', [4 4]);
        b = zscore(rsign(im));
        featureX(k,:) = [a b];
        featureY(k,:) = str2num(elec_dire2(i).name)+5000;
%         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
        k=k+1;
    end
end 
'YOLO'
for i=4:size(elec_dire3,1)
    tempname=strcat(elec3, elec_dire3(i).name,'/');
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
        im=scale(imread(strcat(tempname,tempdir(j).name)));
        im=(bwmorph(im,'remove'));
        a = extractHOGFeatures(im, 'CellSize', [4 4]);
        b = zscore(rsign(im));
        featureX(k,:) = [a b];
        featureY(k,:) = str2num(elec_dire3(i).name(1:(end-8)))+10000;
%         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
        k=k+1;
    end
end 
'ZOLO'
for i=4:size(norm_dire2,1)
    tempname=strcat(sch2, norm_dire2(i).name,'/');
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
        im=scale(imread(strcat(tempname,tempdir(j).name)));
        im=(bwmorph(im,'remove'));
        
        fa = extractHOGFeatures(im, 'CellSize', [4 4]);
        b = zscore(rsign(im));
        featureX(k,:) = [a b];
        featureY(k,:) = -1*str2num(norm_dire2(i).name);
%         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
        k=k+1;
    end
end 
'XXOLO'
%non_circuits
y_count=1000;
prev_j=100000;
for i=4:size(norm_dire1,1)
    tempname=strcat(sch1, norm_dire1(i).name,'/');
    tempdir=dir(tempname);
    for j=4:size(tempdir,1)
        im=scale(imread(strcat(tempname,tempdir(j).name)));
        im=(bwmorph(im,'remove'));
        
        a = extractHOGFeatures(im, 'CellSize', [4 4]);
        b = zscore(rsign(im));
        featureX(k,:) = [a b];
        if(size(str2num(norm_dire1(i).name),2)==2)
            if(prev_j == j)
               featureY(k,:) = -1*y_count;
               prev_j= (j+1);
            else
                prev_j=(j+1);
                y_count = y_count +1;
                featureY(k,:)= -1 * y_count;
            end
        else
            featureY(k,:) = -1*str2num(norm_dire1(i).name) - 10000;
        end
%         featureZ(k,1) = str2num(tempdir(j).name(1:(end-4)));
        k=k+1;
    end
end 



'XYOLO'
  featureX=featureX(1:(k-1),:);
  featureY=featureY(1:(k-1),:);
  featureZ=featureZ(1:(k-1),:);