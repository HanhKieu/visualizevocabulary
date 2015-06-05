addpath(genpath('../'));

framesDirectory = '../frames';
siftDirectory = '../sift';

fileStructs = dir([siftDirectory '/*.mat']); %struct
% fprintf('reading %d total files...\n', length(fileStructs));
% 
% myDescriptors = [];
% myPositions = [];
% myScales = [];
% myOrients = [];
% for i=1:length(fileStructs)
% 
%     fprintf('reading frame %d of %d\n', i, length(fileStructs));
% 
%     load(fileStructs(i).name)
%     numDescriptors = size(descriptors,1); %NUMBER OF ROWS OUR DESCRIPTOR HAS, BASICALLY THE NUMBER OF DESCRIPTORS IN OUR DESCRIPTOR MATRI
% 
%    if(numDescriptors > 0 )
%     numDescriptorsToCollect = min(20, numDescriptors);
%     descriptorIndexes = randperm(numDescriptors,numDescriptorsToCollect);
%     
%     myDescriptors = [myDescriptors; descriptors(descriptorIndexes,:)];
%     myPositions = [myPositions ;positions(descriptorIndexes,:)];
%     myScales = [myScales ; scales(descriptorIndexes,:)];
%     myOrients = [myOrients;orients(descriptorIndexes,:)];
%    end
%    
%    
%    
% 
% end 
%     %load('myVariables.mat')
%     k = 1500; %BEST VALUE TO USE FOR OUR PURPOSES
%    [idx, C] = kmeansML(k,myDescriptors');
%    C = C';
load('myVariables.mat')
counter = 0;
for i=1:length(fileStructs)
    load(fileStructs(i).name)
    numDescriptors = size(descriptors,1);
    for j=1:numDescriptors %goes through each descriptor in selected Image
        closestClusterMatrix = dist2(descriptors(j,:), C); %find the closest cluster or "word" it belongs to
        [M,I] = min(closestClusterMatrix);
        
        
    end
end

        
    
    
    

   