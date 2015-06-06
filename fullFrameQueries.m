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

if loadfile == 0
    for i=1:length(fileStructs)
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
end


   

chosenImage = 206; %the frame query

mybag = abow(chosenImage,:);

distColVector = zeros(length(fileStructs),2); %stores distance values of all bags compared to mybag
%second column stores index
%length(abow,1)
for j=1:size(abow,1) %for each image compare bag of words 
    
    
  
  
    bagImComparingTo = abow(j,:);
    currDist = dot(mybag,bagImComparingTo)/sqrt(dot(mybag,mybag) * dot(bagImComparingTo,bagImComparingTo));
    distColVector(j,1) = currDist;
    distColVector(j,2) = j;
    
   
end

bestFramesMatrix = sortrows(distColVector); %sorts rows from descending order (in this case good for us)
%top 5 of this distColVector is our top 5 distances and also image
%indexes.image indexes located at distColvector(:,2) remember that!

fileName = [siftDirectory '/' fileStructs( bestFramesMatrix(chosenImage,2) ).name];
load(fileName);
myImage  = imread( [framesDirectory '/' imname] );
subplot(2,3,1)
imshow(myImage)
for i = 2:6
    fileName = [siftDirectory '/' fileStructs( bestFramesMatrix(i,2) ).name];
    load(fileName);
    myImage  = imread( [framesDirectory '/' imname] );
    %figure;
    subplot(2,3,i);
    imshow(myImage);
end



        
    
    
    

   