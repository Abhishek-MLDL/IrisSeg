% IrisSeg: A Fast and Robust Iris Segmentation Framework for Non-Ideal Iris Images
% (C) Abhishek Gangwar, Akanksha Joshi, Ashutosh Singh, Alonso-Fernandez, Josef Bigun
% Code URL- https://github.com/cdac-cvml/IrisSeg
% For Code related Queries Contact: abhishekg@cdac.in, akanksha@cdac.in, ashutoshsingh@cdac.in
% Date of current release: June 2016
% (please check the URL above for more recent releases)

%%%% The software accepts an iris image as input, and outputs segmente image
%%%% It is currently capable of handling images acquired in near-infrared (NIR) only.

%%%%  Certain parameters of the code are customizable, please refer README file included 
%%%%  with the code for more information.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Terms and Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  This code is provided "as is", without any warranty, and for research purposes only.
%%%%%  By downloading the code, you agree with the terms and conditions.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Reference   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Please remember to cite following reference [1] if you make use of this code in any publication.
%%%% [1] Abhishek Gangwar, Akanksha Joshi, Ashutosh Singh, Fernando Alonso-Fernandez and Josef Bigun,  
%%%%     IrisSeg: A Fast and Robust Iris Segmentation Framework for Non-Ideal Iris Images, 
%%%%     International Conference on Biometrics (ICB), 2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function   irisseg_main(imagefile)

% imagefile='F:\PIR\databases\Iris\ND-iris-0405\data\02463\02463d834.tiff';
% imagefile='Z:\IrisDatabase\NDIRIS-0405\data\02463\02463d834.tiff';
% imagefile='02463d834.tiff';
Image=imread(imagefile);

if(size(Image,3)==3)
    I = (rgb2gray(Image));
else
    I=Image;
end
[N, M] = size(I);
%% Scale Parameter 
%%% This version of Code has not been verified to work with different Values for
%%% Scale Parameter. Hence We do not recommend Changing value of Scale Parameter below
%%% Changing Scale may provide better time complexity. But we are not sure
%%% about segmentation or recogntion accuracy
scale= 1;
%% Pupil Segmentation Module
[pupilmask, pCentreX, pCentreY, pRadius, flagger, pupil_height] = pupil_segmentation(I);
if (flagger == 0)
    dlmwrite(strcat('ERROR_',db,'_pupil.txt'), imagefile,'-append','delimiter','');
    return;
end

pRadius  = round(pRadius);
pCentreX = round(pCentreX);
pCentreY = round(pCentreY);

%% Coarse Iris Segmentation Module

%%%% Convert iris part to polar
AngRadius1 = pRadius * 8;
if ( (AngRadius1 > pCentreX) || (AngRadius1 > pCentreY) || (AngRadius1 > (M-pCentreX)) || (AngRadius1 < (N-pCentreY)))
    AngRadius = round(max([pCentreX, pCentreY, (M-pCentreX), (N-pCentreY)]));
else
    AngRadius = AngRadius1;
end
polarheight= round((AngRadius-pRadius) * scale);
x_iris = pCentreX;
y_iris = pCentreY;
[polar_iris] = convert_to_polar(I, x_iris, y_iris, AngRadius, pCentreX, pCentreY, pRadius,  polarheight, 360);
%%%% Shift IRIS
polar_iris = shiftiris(polar_iris);

%%% Localaize Iris Boundary

[iboundary,  flagger]= iris_boundary(polar_iris,pRadius);
irisWidth = round(iboundary / scale);

%% Eyelid Occlusion Detection Module

[eyelidmask, adaptImage,Image2, flagger] = geteyelid(I, pCentreX, pCentreY, pRadius, irisWidth,pupil_height, scale);

%% Iris Boundary Refinement Module

[final_CX, final_CY, Final_iRadius, irismask, flagger] = iris_boundary_actual_double(I,adaptImage, eyelidmask, pCentreX, pCentreY, pRadius, irisWidth, scale);

x_iris = final_CX / scale;
y_iris = final_CY /scale;
iRadius = Final_iRadius / scale;

maskedImage = I;
maskedImage(irismask==0)=255;
maskedImage(pupilmask==1)=255;

%% Iris Normalization Module

[polar_iris, polar_mask] = NEWnormaliseiris(maskedImage, x_iris, y_iris, iRadius, pCentreX, pCentreY, pRadius, 64, 512);

%% Create iris Mask

irismask(pupilmask==1)=0;

%% Save Various Images

outpath='output/';
if(~exist(outpath, 'dir'))
    mkdir(outpath);
end

name_index = strfind(imagefile,'\');
if(numel(name_index)==0 ); name_index =0; end
image_name = imagefile(name_index(end)+1:end);

%%%% Save the iris mask
imwrite(irismask, strcat(outpath, 'irismask_', image_name));

%%%% Save Segmented Iris Image
imwrite(maskedImage, strcat(outpath, 'iris_', image_name));

%%%% Save Normalized Iris Image
imwrite(polar_iris, strcat(outpath, 'normalizediris_', image_name));

%%%% Save Normalized Iris Image
imwrite(polar_mask, strcat(outpath, 'normalizedmask_', image_name));
%%%%
end
