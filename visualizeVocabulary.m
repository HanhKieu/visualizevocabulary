addpath('./provided_code/');

framesDirectory = '../frames';
siftDirectory = '../sift/';

% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fileStructs = dir([siftdir '/*.mat']); %struct
fprintf('reading %d total files...\n', length(fnames));

for i=1:length(fileStructs)

    fprintf('reading frame %d of %d\n', i, length(fnames));
    % load that file
    fileSift = [siftDirectory '/' fileStructs(i).name];  %GETS THE MATLAB FILE
    fileSift(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients'); %THE LOAD FUNCTION LOADS THESE VARIABLES FROM fileSift
    numDescriptors = size(descriptors,1); %NUMBER OF ROWS OUR DESCRIPTOR HAS, BASICALLY THE NUMBER OF DESCRIPTORS IN OUR DESCRIPTOR MATRI
    if(numDescriptors > 0) %ONLY GATHER DESCRIPTORS IF THERE ARE DESCRIPTORS
        if(numDescriptors > 20) 
           numOfDescriptorsToCollect = 20; %IF WE HAVE MORE THAN 20 DESCRIPTORS, WE ONLY WANT 20 DESCRIPTORS
        end
        
        
        
        
      
       for i=1:numOfDescriptorsToCollect
           myDescriptors = [myDescriptors; descriptors(1:numOfDescriptorsToCollect,:)];
           myPositions = [myPositions, positions(1:numOfDescriptorsToCollect,:)];
           myScales = [myScales, scales(1:numOfDescriptorsToCollect,:)];
           myOrients = [myOrients, orients(1:numOfDescriptorsToCollect,:)];
       end
    
    end  

end
    k = 1500; %BEST VALUE TO USE FOR OUR PURPOSES
   [idx, C] = kmeansML(k,single(allDescriptors));
   
   