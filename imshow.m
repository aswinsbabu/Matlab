image= imread("/user/HS400/as03510/Tutorials/cv/lab/cvprlab/testimages/sphinx.jpg");
imshow(image);
axis equal;
size(image);
fprintf('%i\n',size(image));
%thresholded = (image >0.15);
%imshow(thresholded);