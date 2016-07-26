% function [accuracy,false_positive_idx,false_negative_idx,prob_neg,prob_pos,prob]=cross_validation_svm(dataY,dataX,no_of_folds)
function [accuracy]=cross_validation_svm(dataY,dataX,no_of_folds)
    % Function for 5-fold cross validation of svm. It takes three inputs dataY is
    % labels(column vector), dataX is features, no_of_folds is no. of folds in cross validation. Output is accuracy(no_of_folds dimension vector), false
    % positive index of all no_of_folds parts, false negative index of all no_of_folds parts.    
    
    positives = find(dataY(:,1)== 1);  %Index of all positive samples
    negatives = find(dataY(:,1)== -1);  %Index of all negative samples
    a=floor(size(dataY,1)/no_of_folds);   
    b=size(dataX,2);
    
    pos=floor(size(positives,1)/no_of_folds);       % Since taking floor atmost 2*(no_of_folds-1) data points can be lost
    neg=floor(size(negatives,1)/no_of_folds);
    sample_dataX=zeros((neg+pos),b,no_of_folds);   
    sample_dataY=zeros((neg+pos),1,no_of_folds);
    index=zeros((neg+pos),1,no_of_folds);
    k=1;
    
    for i=1:pos                            %partition of positive sample data into folds
        for j=1:no_of_folds
            sample_dataX(k,:,j)= dataX(positives((j-1)*pos+i),:);
            sample_dataY(k,:,j)= 1;
            index(k,:,j)= positives((j-1)*pos+i);
        end
        k=k+1;
    end
    
    for i=1:neg                             %partition of negative sample data into folds
        for j=1:no_of_folds
            sample_dataX(k,:,j)= dataX(negatives((j-1)*neg+i),:);
            sample_dataY(k,:,j)= -1;
            index(k,:,j)= negatives((j-1)*neg+i);
        end
        k=k+1;
    end
    
    
    % Evaluating no_of_folds SVMs and their prediction
    for i=1:no_of_folds
        labels=zeros((no_of_folds-1)*(neg+pos),1);
        features=zeros((no_of_folds-1)*(neg+pos),b);
        k=0;
        for j=1:no_of_folds
            if(i~=j)
                labels(k*(neg+pos)+1:(k+1)*(neg+pos),:) =sample_dataY(:,:,j);
                features(k*(neg+pos)+1:(k+1)*(neg+pos),:)=sample_dataX(:,:,j);
                k=k+1;
            end
        end
        svm(i)=svmtrain(labels,features,'-t 0 -b 1');
        [pred(:,1,i),accur(i,:),prob(:,:,i)]=svmpredict(sample_dataY(:,:,i),sample_dataX(:,:,i),svm(i),'-b 1');  
    end
    size(prob)
    % Accuracy of each fold
    for i=1:no_of_folds
        accuracy(i)=accur(i,1);
    end
    
    
    % Index of false positives and negatives
    p_i=1; %Counter for negative and positive index resp.
    n_i=1;
    for j=1:no_of_folds
        for i=1:size(pred,1)
            if(sample_dataY(i,1,j)==1 && pred(i,1,j)==-1)
                false_negative_idx(n_i)=index(i,1,j);
                prob_neg(n_i,:)=prob(i,:,j);
                n_i=n_i+1;
            end
            if(sample_dataY(i,1,j)==-1 && pred(i,1,j)==1)
                false_positive_idx(p_i)=index(i,1,j);
                prob_pos(p_i,:)=prob(i,:,j);
                p_i=p_i+1;
            end
        end
    end
    
end

