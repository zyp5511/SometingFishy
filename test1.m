function test1(filename,n)
I = imread(filename);
[width,height,v] = size(I);

fish= zeros(width,height,'logical');
srgb2lab = makecform('srgb2lab');
lab2srgb = makecform('lab2srgb');

shadow_lab = applycform(I, srgb2lab); % convert to L*a*b*

% the values of luminosity can span a range from 0 to 100; scale them
% to [0 1] range (appropriate for MATLAB(R) intensity images of class double)
% before applying the three contrast enhancement techniques
max_luminosity = 45;
L = shadow_lab(:,:,1)/max_luminosity;

% replace the luminosity layer with the processed data and then convert
% the image back to the RGB colorspace
shadow_imadjust = shadow_lab;
shadow_imadjust(:,:,1) = imadjust(L)*max_luminosity;
shadow_imadjust = applycform(shadow_imadjust, lab2srgb);

[a,b]=createMask(shadow_imadjust);


[L num]= bwlabel(~a);
threshold=L(round(width/2),round(height/2)); 
for i= 1:width-1
    for j=1:height-1
        if L(i,j)== threshold;
            fish(i,j)=1;
        end
    end
end


name = strcat(filename,'.tif')
imwrite(fish,name)

% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 0);
% 
% BWsdil = imdilate(a, [se90 se0]);
% figure, imshow(BWsdil),
% 
% % BWdfill = imfill(BWsdil, 'holes');
% % figure, imshow(BWdfill);
% 
% BWnobord = imclearborder(BWsdil, 4);
% figure, imshow(BWnobord),


end

