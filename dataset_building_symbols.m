% This function is to randomly select test and training samples from the
% dataset.
data_dir = 'C:\Users\shubham\Desktop\BTP\symbols_dataset\combined_dataset_train_test\junction\';
% train_dir = ''
test_dir = 'C:\Users\shubham\Desktop\BTP\symbols_dataset\combined_dataset_train_test\junction_test\';
mkdir(test_dir)
l=1;
k=100;   %No. of samples that you want in test dataset
while(l<k+1)
    a1=dir(data_dir);
    random = randi([1 size(a1,1)],1,1);
    if(~(strcmp(a1(random).name,'.') == 1 | strcmp(a1(random).name,'..')==1 | strcmp(a1(random).name,'Thumbs.db') == 1))
        l=l+1;
        movefile(strcat(data_dir,a1(random).name),test_dir);
    end
end