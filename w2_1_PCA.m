%Create a distribution of 5000 random 2D points, with %x’ and ‘y’ coordinates in the range [0,1].
pt = rand(2,5000); %why 2?
% Plot them.
plot(pt(1,:),pt(2,:),'bx'); %bx?

%Next Step:
% %Turn these into 3D points by adding a %z’ coordinate, set to zero for all points.
pt(3,:)=0;
% The points in pt are now 3D points, all lying along the plane z=0. Plot this in 3D to check:‐
%plot3(pt(1,:), pt(2,:), pt(3,:), 'rx');

%Next Step:
% Multiply the y coordinate of the points by 5.
pt(2,:)=pt(2,:) * 5;
%The points now lie range from x=[0,1], y=[0,5], and z=0.
% Repeat the “plot3” step above to check. i.e.
%plot3(pt(1,:), pt(2,:), pt(3,:), 'rx');

% You can label the axes using the xlabel, ylabel and zlabel commands. For example:
xlabel ('X axis');
ylabel ('Y axis');
zlabel ('Z axis');
