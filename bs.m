
myDescriptors = [];
myPositions = [];


addpath('./provided_code/');

framesdir = '/usr/local/189data/frames/';
siftdir = '/usr/local/189data/sift/';

% Get a list of all the .mat files in that directory.
% There is one .mat file per image.
fnames = dir([siftdir '/*.mat']);

fprintf('reading %d total files...\n', length(fnames));

for i=1:length(fnames)

    fprintf('reading frame %d of %d\n', i, length(fnames));
    
    % load that file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    numfeats = size(descriptors,1);
    if(numfeats == 0)
        if(numfeats > 25)
           numfeats = 25;
        end
        % get the SIFT descriptors 
       for i=1:numfeats
           myDescriptors = [myDescriptors; descriptors];
           allPositions = [myPositions, positions];
           allScales = [myScales, scales];
           allOrients = [allOrients, orients];
       end
       %  randomly sample from each  
    end  
    % read in the associated image
    imname = [framesdir '/' imname]; % add the full path
    im = imread(imname);
end
    k = 1500;
   [idx,centers] = kmeansML(k,single(allDescriptors));