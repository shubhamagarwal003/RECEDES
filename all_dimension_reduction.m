nCentres = 20;
nDimension = 15;
% red_dimension=zeros(34,12083,nDimension);
% symbols_svm=zeros(34,410,nCentres);
types=['PCA           '; 'LDA           '; 'MDS           '; 'ProbPCA       '; 'FactorAnalysis'; 'GPLVM         '; 
  'Sammon        '; 'Isomap        '; 'LandmarkIsomap'; 'LLE           '; 'Laplacian     '; 'HessianLLE    '; 
  'LTSA          '; 'MVU           '; 'CCA           '; 'LandmarkMVU   '; 'FastMVU       '; 'DiffusionMaps '; 
  'KernelPCA     '; 'GDA           '; 'SNE           '; 'SymSNE        '; 'tSNE          '; 'LPP           '; 'NPE           '; 'LLTSA         '; 
  'SPE           '; 'Autoencoder   '; 'LLC           '; 'ManifoldChart '; 'CFA           '; 'NCA           ';'MCML          ';'LMNN          '];
i=4;
types=cellstr(types);
% for i=23:size(types,1)  %8 and 9 remaining. 7, 10 giving error. 5,6 not working bcoz matrix is close to singular. 
                        %Some errors in 11 After dimension reduction
                        %size(scoreX,1) != size(featureX,1). 12 taking too
                        %much time. 13 Error. 14 error. After that started.
                        %19 too much time
                        %from 23
    tic
    [acc(i,:)]=unsupervised_cluster_group(featureX,featureY,nCentres,nDimension,cell2mat(types(i,:)));
    time(i,:)=toc;
% end
