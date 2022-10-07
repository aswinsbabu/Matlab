%Create a distribution of 5000 random 2D points, with %x’ and ‘y’ coordinates in the range [0,1].
pt = rand(2,5000); %why 2?
% Plot them.
%plot(pt(1,:),pt(2,:),'bx'); %bx?

%Next Step:
% %Turn these into 3D points by adding a %z’ coordinate, set to zero for all points.
pt(3,:)=0;
% The points in pt are now 3D points, all lying along the plane z=0. Plot this in 3D to check:‐
%plot3(pt(1,:), pt(2,:), pt(3,:), 'rx');

%Next Step:
% Multiply the y coordinate of the points by 5.
pt(2,:)=pt(2,:) * 5;
% %The points now lie range from x=[0,1], y=[0,5], and z=0.
% % Repeat the “plot3” step above to check. i.e.

%plot3(pt(1,:), pt(2,:), pt(3,:), 'rx');
% 
% % You can label the axes using the xlabel, ylabel and zlabel commands. For example:
% xlabel ('X axis');
% ylabel ('Y axis');
% zlabel ('Z axis');



% We will now build an Eigenmodel from this 3D data, and use it to determine the modes of variation in the data.
% The eigenmodel will comprise a mean, 3 eigenvectors and 3 corresponding eigenvalues (because the data has 3
% dimensions).
% Predictions:
% We predict the direction of greatest variation in the data to point along the y axis; i.e. the principal
% eigenvector (the eigenvector with the largest eigenvalue) to point along the y axis because these values are
% of range [0,5].
% We would predict the eigenvector with the second largest eigenvalue would point along the x axis, as these
% points are of range [0,1].
% Would would expect the third eigenvector to have a near‐zero eigenvalue, because all points have z=0
% Experiment (check the predictions):

% Build the eigenmodel using the Eigen_Build function supplied in the lab code:

e = Eigen_Build(pt)
% 
% % e =
% % D:
% % N: 5000
% % 3
% % org: [3x1 double]
% % vct: [3x3 double]
% % val: [3x1 double]
% % Here N is the number of observations used to build the model (5000), the dimension of the observations (3) and the
% % fields ‘org’, ‘vct’ and ‘val’ are the mean, eigenvectors and eigenvalues respectively of the resulting eigenmodel.
% 
% % Examine the eigenvalues. Due to the random generation of the points, your values will differ slightly:
% e.val
% 
% % ans = 2.0683
% % 0.0830
% % 0
% 
% % Now look at the eigenvectors corresponding to these. Remember each column of ‘vct’ is an eigenvector.
% e.vct

% ans =
% ‐0.0013
% ‐1.0000
% 0
% ‐1.0000
% 0.0013
% 0
% 0
% 0
% 1.0000
% Again, your values will vary. However you should see that the first eigenvector is roughly [0 1 0]T i.e. pointing along
% the y axis, the second along the x axis, and the third along the z axis. This is just as we predicted.
% Clearly the first eigenvalue is much larger than the second. This is because the spread of points is 5 times larger
% along the y axis (the first i.e. principal eigenvector) versus the second (the x axis). That is, the standard deviation is 5
% times as large. The variance (square of the standard deviation) should thus be 25 times as large. Recall the
% eigenvalues encode the variance along each eigenvector. Divide the first eigenvalue by the second; you should
% observe a factor of approximately 25.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% eXPERIMENT 2  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Ex2: Repeating Ex1 ‐ computing the Eigenmodel manually ‐ (15 minutes)
% In this exercise you will repeat the analysis of Ex1, but working out the PCA yourself rather than using the EigenBuild
% code supplied by your lecturer.

% First, compute the mean of the 3D points in pt. Recall this is done by averaging the x, y, and z dimensions of the
% points. You can do this quickly (take care with the apostrophes) via:
org=mean(pt')';
org

% Or you can use:
% >> x=sum(pt(1,:))/5000;
% >> y=sum(pt(2,:))/5000;
% >> z=sum(pt(3,:))/5000;
% >> org = [x ; y ; z];


% Now subtract the mean from the points in pt:
ptsub = pt-repmat(org,1,5000);
% Note we used repmat to repeat the ‘org’ column 5000 times to create a matrix the same size as pt, suitable for the
% subtraction. Matlab would not have accepted ptsub=pt‐org due to a matrix size mismatch.

% Now compute the 3x3 covariance matrix from ptsub:
C = (ptsub*ptsub') ./ 5000;

% Finally, decompose the covariance matrix into its eigenvector and eigenvalues:
% ['vct' 'val'] = eig(C);
% ['vct' , 'val'] = eig(C);
%[vct, val] = eig(C);
%vct, val = eig(C);
[vct val] = eig(C);

% Examine org, vct, val and compare them to your previously computed e.org, e.vct, and e.val.
vct
e.vct

val
e.val

org
e.org



% Some notes:
% 1. the eigenvalues are presented as a diagonal matrix rather than a column.
% 2. the eigenvalues and their respective eigenvectors may be in a different order. The columns of vct map to
% columns in val.
% 3. the eigenvectors might point the opposite way – this is an ambiguity in the solution for the eigen‐
% decomposition. It does not matter; the eigenvectors point along the direction of variation (which is sign
% independent) and the eigenvalues simply specify the variance in that direction of variation.

