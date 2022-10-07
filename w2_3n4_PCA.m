
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EXP 3 and 4: Distance from an eigenmodel and Mahalanobis Distance %%%%%%%%%%%%%%%%%%%%

%%% EXP 3: Distance from an eigenmodel (15 minutes) %%%%%%%%%%%%%%%%%%%%
%seperate experiment: Non dependent from Exp 1,2

% In this exercise we will build another Eigenmodel from 3D data. Rather than being random these 3D data will
% comprise red, green and blue (RGB) pixel values sampled from the image of a “target” object we would like to find.

% We will use a distinctively coloured yellow object as our target. We will learn it’s colour distribution (by fitting an
% Eigenmodel to it’s pixel data) then examine pixels in a new image of the object to determine which pixels are likely
% to form part of that distribution form part of the target. This will be achieved by measuring “distance” from the
% Eigenmodel in standard deviations. This distance is the Mahalanobis distance covered in lectures.


% First, load the target image and normalise it so the red, green and blue values range [0,1]instead of [0,255].
% Although this normalisation is unnecessary we will do it for purpose of forming good habits. 
% 
% The image is a patch of
% colour cropped from a photo of the yellow object – it is the training data.
target=double(imread('/user/HS400/as03510/Tutorials/cv/lab/cvprlab/testimages/target_yellow.bmp'))./255;

% Create a matrix of RGB pixel values from the target image. Each column in the matrix will one pixel’s RGB value, i.e.
% the matrix will contain three rows, for red green and blue respectively. It will contain a column for each of the 1457
% pixels in this test image:

target_obs=[reshape(target(:,:,1),1,[]); reshape(target(:,:,2),1,[]);reshape(target(:,:,3),1,[])];

% The variable target_obs now contains 1457 data points, from which we build an Eigenmodel:
target_e = Eigen_Build(target_obs);

% We have now modelling the target’s colour distribution, and will seek pixels of similar colour in a new “test” image
% to try to locate the pen. First, load the test image:
test = double(imread('kitchen.bmp'))./255;

% Now obtain a matrix of RGB values; again, one column (data point) per pixel. Here there are 320x240 pixels, i.e.
% ~77k pixels:
test_obs=[reshape(test(:,:,1),1,[]); reshape(test(:,:,2),1,[]) ;reshape(test(:,:,3),1,[]) ];

% We will now compute the Mahalanobis distance of each of the 77k data points from the Eigenmodel:
mdist = Eigen_Mahalanobis(test_obs,target_e);

%The resulting  mdist% is a single row with 77k columns, each containing a value for each pixel that encodes distance
% from the colour model. We can reshape ‘mdist’ from a 1x76800 matrix back into a matrix of 240 x 320 in order to
% visualize the result.
result = reshape(mdist,size(test,1),size(test,2));

% The values in result will range from 0 to some large positive value. We can find the maximum value in ‘result’ and
% divide each pixel by it, to get a normalised result ‘nresult’ with pixels in range [0,1] which we can then display.
nresult=result./ max(max(result));
imgshow(nresult);

% The darker pixels have lower Mahalanobis distance i.e. are closer to the colour model. The pen should therefore be
% picked out with darker intensity pixels. We can threshold the image at 3 standard deviations:
imgshow (result < 3);



%%%%%%%%%%%%%%%%%%%%% Ex.4: Compute the Mahalanobis Distance manually (10 minutes) 
% We will now manually compute the Mahalanobis distance of one of the pixels from the Eigenmodel, as an exercise.

% First, select one of the pixels in the image. The first pixel in the ‘test_obs’ matrix will suffice:
x=test_obs(:,1)
% x =
% 0.2941
% 0.2118
% 0.0510

%First, subtract the mean of the eigenmodel:
xsub = x-target_e.org;

%Now use the equation discuss during lectures to compute the square of the Mahalanobis distance (i.e. the distance
% of the point ‘x’ from the eigenmodel in units of variance).

V= diag(target_e.val);
U= target_e.vct;
mdist_squared = xsub' * U * inv(V) * U' * xsub;

% So the square root of ‘mdist_squared’ is the Mahalanobis distance of ‘x’ from the model:
sqrt(mdist_squared)

% Which should correspond to the first column of the Mahalanobis distances previously computed in Ex.3:
mdist(1)
