% IrisSeg: A Fast and Robust Iris Segmentation Framework for Non-Ideal Iris Images
% (C) Abhishek Gangwar, Akanksha Joshi, Ashutosh Singh, Alonso-Fernandez, Josef Bigun
% Code URL- https://github.com/cdac-cvml/IrisSeg
% For Code related Queries Contact: abhishekg@cdac.in, akanksha@cdac.in
% Date of current release: June 2016
% (please check the URL above for more recent releases)

%%%% The software accepts an iris image as input, and outputs segmente image
%%%% It is currently capable of handling images acquired both in near-infrared (NIR) only.

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

%%  How to use this function
%%% Below code demostrate an example o segment multiple images using
%%% iris_seg
addpath(genpath('modules'))
%% Set variables
input_folder='data';
outpath='output/';

if(~exist(outpath, 'dir'))
    mkdir(outpath);
end
%% Read images
images=dir(strcat(input_folder, '/*.tiff'));

for i=1:numel(images)
    image_name= images(i).name;
    
    imagefile=imread(strcat(input_folder,'/', image_name));
    
    [irismask, maskedImage, polar_iris, polar_mask]=irisseg_main(imagefile);
    
    %% Save Various Images
    
    %%%% Save the iris mask
    imwrite(irismask, strcat(outpath, 'irismask_', image_name));
    
    %%%% Save Segmented Iris Image
    imwrite(maskedImage, strcat(outpath, 'iris_', image_name));
    
    %%%% Save Normalized Iris Image
    imwrite(polar_iris, strcat(outpath, 'normalizediris_', image_name));
    
    %%%% Save Normalized Iris Image
    imwrite(polar_mask, strcat(outpath, 'normalizedmask_', image_name));
    
end
