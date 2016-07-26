dire='C:\Users\shubham\Desktop\BTP\image_dataset\circuit_symbols\';
% dire1='C:\Users\shubham\Desktop\BTP\image_dataset\non_circuits\';
% files_temp=dir(dire);
% zbf = zernike_bf(100,25);
% % keys={'capac','trans','groun','induc','opamp','resis','diode'};
% dataX=zeros(5000,363);
% dataY=zeros(5000,1);
k=0;
% size(files_temp)
% for i=1:size(keys,2)
%     if(~isequal(files_temp(i).name,'Thumbs.db'))
%     temp=char(strcat(dire,keys(i),'_dataset_train\'));
%     files=dir(temp)
i=0;
for i=1:
    i
    if(i==1)
        files=dir(dire);
    else
        files=dir(dire1);
    end
    for j=1:size(files,1)
%         files(j).name
        if(length(files(j).name)>3 && ~isequal(files(j).name,'Thumbs.db'))
            if(i==1)
                addr=strcat(dire,files(j).name);
            else
                addr=strcat(dire1,files(j).name);
            end
            img=readtobin(addr);
            rsigni=zscore(rsign(img));
            zernike = zscore(abs(zernike_mom(img,zbf)));
            feat = zeros(363,1);
            feat(1:181)=rsigni;
            feat(182:end)=zernike;
            k=k+1;
            dataX(k,:)=feat;
            dataY(k)=i;
        end
        clear img;
    end
    end

% dataXtest=zeros(5000,181);
% dataYtest=zeros(5000,1);
% k=0;
% for i=1:size(keys,2)
%     if(i==7)
%         temp=char(strcat(dire,keys(i),'_dataser_test\'));
%     else
%         temp=char(strcat(dire,keys(i),'_dataset_test\'));
%     end
%     files=dir(temp);
%     for j=1:size(files,1)
%         files(j).name
%         if(length(files(j).name)>3 && ~isequal(files(j).name,'Thumbs.db'))
%             addr=strcat(temp,files(j).name);
%             img=readtobin(addr);
%             rsigni=rsign(img);
%             zernike = zernike_mom(img,zbf);
%             feat = zeros(363,1);
%             feat(1:181)=rsigni;
%             feat(182:end)=zernike;
%             k=k+1;
%             dataXtest(k,:)=feat;
%             dataYtest(k)=i;
%         end
%         clear img;
%     end
% end
% 
% ab=find(dataX(:,1)==0);
% dataX=dataX(1:(ab(1)-1),:);
% ab=find(dataXtest(:,1)==0);
% dataXtest=dataXtest(1:(ab(1)-1),:);