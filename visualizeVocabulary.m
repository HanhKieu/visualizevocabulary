addpath(genpath('../'));

framesDirectory = '../frames';
siftDirectory = '../sift';

fileStructs = dir([siftDirectory '/*.mat']); %struct
jpegStructs = dir([framesDirectory '/*jpeg']);
fprintf('reading %d total files...\n', length(fileStructs));

myDescriptors = [];
myPositions = [];
myScales = [];
myOrients = [];
loadfile = 1;

if loadfile == 0
    for i=1:length(fileStructs)

        fprintf('reading frame %d of %d\n', i, length(fileStructs));

        load(fileStructs(i).name)
        numDescriptors = size(descriptors,1); %NUMBER OF ROWS OUR DESCRIPTOR HAS, BASICALLY THE NUMBER OF DESCRIPTORS IN OUR DESCRIPTOR MATRI

       if(numDescriptors >= 20 )
%         numDescriptorsToCollect = min(20, numDescriptors);
        numDescriptors = 20;
        descriptorIndexes = randperm(numDescriptors,numDescriptorsToCollect);

        myDescriptors = [myDescriptors; descriptors(descriptorIndexes,:)];
        myPositions = [myPositions ;positions(descriptorIndexes,:)];
        myScales = [myScales ; scales(descriptorIndexes,:)];
        myOrients = [myOrients;orients(descriptorIndexes,:)];
       end




    end
        k = 1500; %BEST VALUE TO USE FOR OUR PURPOSES
       [idx, C] = kmeansML(k,myDescriptors');
       C = C';
end
if loadfile == 1
    load('myVariables.mat')
end




counter = 0;
word = 3;
quitV = 0;
figure;

for i=1:length(fileStructs)
    load(fileStructs(i).name)
    numDescriptors = size(descriptors,1);
    for j=1:numDescriptors %goes through each descriptor in selected Image
        closestClusterMatrix = dist2(descriptors(j,:), C); %find the closest cluster or "word" it belongs to
        [M,currentWord] = min(closestClusterMatrix);
        if(currentWord == word )
            counter = counter + 1;
            imPath = strcat('../frames/',jpegStructs(i).name);
            im = imread(imPath);
            im = rgb2gray(im);
            myPatch = getPatchFromSIFTParameters(positions(j,:), scales(j,:), orients(j,:), im);
            
            subplot(5,5,counter);
            imshow(myPatch);
            
            if(counter == 25)
                quitV = 1;
                break
            end
            
        end
        
        
        
        
    end
    if quitV == 1
        break;
    end
end

        
    
    
    

   