dire='C:\Users\shubham\Desktop\image_dataset\schematics\shedded_images_new\';
% zbf = zernike_bf(100,25);
files=dir(dire);
dataX=zeros(500,3);
dataY=zeros(500,3);
% k=0;
for i=3:size(files,1)
    dire_temp=strcat(dire,files(i).name,'\');
    files_temp=dir(dire_temp);
    k=k+1
    n_si=size(files_temp,1);
    for j=3:n_si
%         j
        if(~isequal(files_temp(j).name,'Thumbs.db'))
            addr=strcat(dire_temp,files_temp(j).name);
            img=imread(addr);
            img=im2bw(img,graythresh(img));
            [m n]=size(img);
            white=sum(sum(img==1));
            black=sum(sum(img==0));
            if((m>20 | n>20) && m>10 && n>10 && white/black>0.4)
                img=readtobin(addr);
                rsigni=zscore(rsign(img));
                zernike = zscore(abs(zernike_mom(img,zbf)));
                feat = zeros(363,1);
                feat(1:181)=rsigni;
                feat(182:end)=zernike;
                feat=feat';
                feat=feat./colMax;
                [predicted_label] = svmpredict(1, feat, svm,'-q');
                dataX(k,predicted_label)=dataX(k,predicted_label)+1;
            end
        end
    end
    dataX(k,:)=dataX(k,:)/size(files_temp,1);
    dataX(k,3)=size(files_temp,1);
    dataY(k)=1;
end
