jpegFiles = dir('*.jpg'); 
numfiles = length(jpegFiles);
for k = 1:numfiles 
    test1(jpegFiles(k).name,k);
end