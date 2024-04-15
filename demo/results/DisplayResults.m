% Display EMI-added (Deep-DSP model input) and EMI-eliminated (Deep-DSP model output) images
% =========================================================================

clear all;close all;clc;

root = '.\';
dir  = [root 'demo\results\'];
sub_file = {'input','output'};
Nfile = size(sub_file,2);

ksize = [128 128 3];
kmax  = 30;

for ii = 1:Nfile
    dir_tmp  = [dir, sub_file{ii}, '.h5'];
    data_tmp = h5read(dir_tmp,'/k-space');
    ksp(:,:,:,ii) = reshape(squeeze(data_tmp(:,1,:) + 1i*data_tmp(:,2,:)),ksize)/kmax;
    clear dir_tmp data_tmp
end

img_disp = reshape(ksp,[128 128*3 2]);
figure,t = tiledlayout(2,1,'TileSpacing','compact');
nexttile,imshow(abs(img_disp(:,:,1)));title('EMI-added k-space');
nexttile,imshow(abs(img_disp(:,:,2)));title('EMI-eliminated k-space');

img_disp = reshape(flip(ifft2c(ksp),1),[128 128*3 2]);
figure,t = tiledlayout(2,1,'TileSpacing','compact');
nexttile,imshow(abs(img_disp(:,:,1)));title('EMI-added images');
nexttile,imshow(abs(img_disp(:,:,2)));title('EMI-eliminated images');





