load('twoFrameData.mat')
region= selectRegion(im1,positions1); %returns list of positions that fell within polygon
regionRows = size(region,1);

d = descriptors1(region,:);
distance = dist2(d, descriptors2);g

[M , I] = min(distance); %smallest values of each column in a row matrix and row indexes in which it occurs
myVector = find(M < .1); %returns 

myPos = positions2(myVector, :);
myScale = scales2(myVector, :);
myOrients = orients2(myVector, :);


figure
imshow(im2)
hold on
displaySIFTPatches(myPos , myScale, myOrients, im2);
    

