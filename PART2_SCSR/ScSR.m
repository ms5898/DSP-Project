%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Super resolution via Sparse Coding func.
%  reference:
% [1] J. Yang et al. Image super-resolution via sparse representation. IEEE 
%     Transactions on Image Processing, Vol 19, Issue 11, pp2861-2873, 2010
%
% [2] code provided by the author: http://www.ifp.illinois.edu/~jyang29/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [hr_img] = ScSR(Y, up_scale, Dh, Dl, lambda, overlap)

% normalize the dictionary
norm_Dl = sqrt(sum(Dl.^2, 1)); 
Dl = Dl./repmat(norm_Dl, size(Dl, 1), 1);
patch_size = sqrt(size(Dh, 1));

% use bicubic interpolation to generate a target size low resolution image
% from the input Y
lr_img = single(imresize(Y, up_scale, 'bicubic'));
[height, width] = size(lr_img);

hr_img = zeros(size(lr_img)); % zero matrix for high resolution image
cntMat = zeros(size(lr_img)); % count for parts that are not processed

% extract low-resolution image features
lr_feature = extr_lIm_fea(lr_img);

% index matrix of patches(5*5) extracted from lr_img
% ignore the starting pixel, start from the second one
patch_x = 3:patch_size - overlap : width-patch_size-2;
patch_x = [patch_x, width-patch_size-2];
patch_y = 3:patch_size - overlap : height-patch_size-2;
patch_y = [patch_y, height-patch_size-2];

A = Dl'*Dl; % optimization parameter

% Implementation of Algorithm 1 in article
% process each low resolution patch of input to produce high resolution
% patch and put into high resolution image
for i = 1:length(patch_x)
    for j = 1:length(patch_y)
        % read patch index (start point)
        x = patch_x(i); y = patch_y(j);
        
        % extract patch from lr_img and preprocess
        patch = lr_img(y:y+patch_size-1, x:x+patch_size-1);
        patch_mean = mean(patch(:));
        patch = patch(:) - patch_mean;
        patch_norm = sqrt(sum(patch.^2));
        
        % extract patch feature from image feature
        patch_feature = lr_feature(y:y+patch_size-1, x:x+patch_size-1, :);   
        patch_feature = patch_feature(:);
        % feature normalization
        feature_norm = sqrt(sum(patch_feature.^2));
        if feature_norm > 1
            f = patch_feature./feature_norm;
        else
            f = patch_feature;
        end
        
        b = -Dl'*f; %optimization parameter
      
        % solve optimization problem using original function
        alpha = L1QP_FeatureSign_yang(lambda, A, b);
        
        % generate the high resolution patch & resize +mean
        hr_patch = Dh*alpha;
        hr_patch = lin_scale(hr_patch, patch_norm);
        hr_patch = reshape(hr_patch, [patch_size, patch_size]);
        hr_patch = hr_patch + patch_mean;

        % put into high resolution image matrix hr_img
        % record corresponding position in cntMat as "reconstructed"
        hr_img(y:y+patch_size-1, x:x+patch_size-1) = hr_img(y:y+patch_size-1, x:x+patch_size-1) + hr_patch;
        cntMat(y:y+patch_size-1, x:x+patch_size-1) = cntMat(y:y+patch_size-1, x:x+patch_size-1) + 1;
    end
end

% fill in the empty with bicubic interpolation
idx = (cntMat < 1);
hr_img(idx) = lr_img(idx);

cntMat(idx) = 1;
hr_img = hr_img./cntMat;
hr_img = uint8(hr_img);
