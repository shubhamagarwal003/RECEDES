dire='C:\Users\shubham\Desktop\BTP\symbols_dataset\combined_dataset_train_test\';  %Put appropriate directory
% files=dir(dire)
keys={'capacitor','transistor','ground','inductor','opamp','resistor','diode','junction'};
dataX_radon=zeros(3000,181);
dataX=zeros(3000,2500);
dataX_hog = zeros(3000,4356);               %put appropriate dimension
dataY=zeros(3000,1);
k=0;
for i=1:size(keys,2)
    temp=char(strcat(dire,keys(i),'\',keys(i),'_train\'));            %change \ to /
    files=dir(temp);
    i
    for j=1:size(files,1)
        if(~(strcmp(files(j).name,'.') == 1 || strcmp(files(j).name,'..')==1 || strcmp(files(j).name,'Thumbs.db') == 1))
            addr=strcat(temp,files(j).name);
            img=readtobin(addr);
            k=k+1;
            dataY(k,:)=i;
%             dataX_hog(k,:)=extract      %Extract Hog Features 
            dataX_radon(k,:)=rsign(img);
            dataX(k,:)=reshape(img,[2500 1]);
        end
    end
end
dataX_radon=dataX_radon(1:k,:);
% dataX_hog=dataX_hog(1:k,:);
dataY=dataY(1:k,:); 
dataX=dataX(1:k,:);


dataX_test_radon=zeros(3000,181);
dataX_test=zeros(3000,2500);
dataX_test_hog=zeros(3000,4356);            %put appropriate dimension
dataY_test=zeros(3000,1);
k=0;
for i=1:size(keys,2)
    temp=char(strcat(dire,keys(i),'\',keys(i),'_test\'));           %change \ to /
    files=dir(temp);
    i
    for j=1:size(files,1)
        if(~(strcmp(files(j).name,'.') == 1 || strcmp(files(j).name,'..')==1 || strcmp(files(j).name,'Thumbs.db') == 1))
            addr=strcat(temp,files(j).name);
            img=readtobin(addr);
            k=k+1;
%             dataY_test(k,i)=1;
            dataY_test(k,:)=i;
%             dataX_hog(k,:)=extract      %Extract Hog Features 
%             dataX_radon(k,:)=rsign(img);
            dataX_test(k,:)=reshape(img,[2500 1]);
            dataX_test_radon(k,:)=rsign(readtobin(addr));
%             dataX_test_hog(k,:)=extract      %Extract Hog Features 
        end
    end
end
dataX_test=dataX_test(1:k,:);
dataX_test_hog=dataX_test_hog(1:k,:);
dataX_test_radon=dataX_test_radon(1:k,:);
dataY_test=dataY_test(1:k,:); 

% ab=find(dataXtest(:,1)==0);
% dataXtest=dataXtest(1:(ab(1)-1),:);