clc,clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Main program
%   For read image data, do the SCSR algorithm and results comparison
% Referance
% code provided by author at: http://www.ifp.illinois.edu/~jyang29/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read test image
img = imread('Data/butterfly.bmp');
[row,col,c] = size(img);
%  use bicubic interpolation to produce low resolution image
lr_img = imresize(img, [row/2, col/2], 'bicubic');
% simple digital zooming results
im_b = imresize(lr_img, [row, col], 'bicubic');

% set parameters
lambda = 0.2;                   % optimization Lagrange parameter
overlap = 4;                    % the more overlap the better (patch size 5x5)
up_scale = 2;                   % scaling factor, depending on the trained dictionary

% load provided dictionary
load('Dictionary/D_1024_0.15_5.mat');

% change color space & extract channels, only work on illuminance
lr_ycbcr = rgb2ycbcr(lr_img);
lr_y = lr_ycbcr(:, :, 1);
lr_cb = lr_ycbcr(:, :, 2);
lr_cr = lr_ycbcr(:, :, 3);

% run SCSR algorithm
[hr_y] = ScSR(lr_y, 2, Dh, Dl, lambda, overlap);
[hr_y] = backprojection(hr_y, lr_y, 20);

% upscale the chrominance simply by "bicubic" 
[nrow, ncol] = size(hr_y);
hr_cb = imresize(lr_cb, [nrow, ncol], 'bicubic');
hr_cr = imresize(lr_cr, [nrow, ncol], 'bicubic');
% construct high resolution image
hr_ycbcr = zeros([nrow, ncol, 3]);
hr_ycbcr(:, :, 1) = hr_y;
hr_ycbcr(:, :, 2) = hr_cb;
hr_ycbcr(:, :, 3) = hr_cr;
hr_img = ycbcr2rgb(uint8(hr_ycbcr));

% compute PSNR and show results
bb_psnr = psnr(im_b,img); sp_psnr = psnr(hr_img,img);
fprintf('PSNR for Bicubic Interpolation: %f dB\n', bb_psnr);
fprintf('PSNR for Sparse Representation Recovery: %f dB\n', sp_psnr);

% show the result image
subplot(1,3,1);imshow(img);title('Original Image');
subplot(1,3,2);imshow(im_b);title('Bicubic blur');
subplot(1,3,3);imshow(hr_img);title('Sparse Recovery');