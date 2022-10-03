image= imread("/user/HS400/as03510/Tutorials/cv/lab/cvprlab/testimages/sphinx.jpg");
imgshow(image);
axis equal;
%size(image);
fprintf('%i\n',size(image));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p= image(3,2,:); %rgb VALUE of pixel 2,3
r=image(3,2,1);
g=image(3,2,2);
b=image(3,2,3);

fprintf('%i \n',p);
fprintf('r=%i \n g=%i  \n b=%i',r,g,b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%thresholded = (image >0.15);
%imshow(thresholded);
