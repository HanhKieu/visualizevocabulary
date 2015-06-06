ABOW = []; %ALL BAG OF WORDS

addpath(genpath('../'));

framesDirectory = '../frames';
siftDirectory = '../sift';

fileStructs = dir([siftDirectory '/*.mat']); %struct
jpegStructs = dir([framesDirectory '/*jpeg']);

abow = [];%allbagofwords
bow = [];
loadfile = 1;
k = 1500;
if loadfile == 1  
    load('myVariables.mat');
end


for i=1:3
    load(fileStructs(i).name)
    bow = zeros(1,k); %k is 1500 for our purposes 
    %create a bag of words. Basically a vector of counters
    numDescriptors = size(descriptors,1);
    distanceMatrix = dist2(descriptors, C);
    [M, indexMatrix] = min(distanceMatrix,[],2); %indexMatrix contains indice of rows with min value in column
    for j=1:numDescriptors
        bow(1,indexMatrix(j)) = bow(1,indexMatrix(j)) + 1;
    end
    
    abow = [abow; bow];%abow is a all bag of words, basically the accumulator for all our bag of words
    
end

    
    

        
    
    
    

   