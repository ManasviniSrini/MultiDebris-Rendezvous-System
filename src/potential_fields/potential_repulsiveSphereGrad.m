%function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)
%Compute the gradient of $U_ rep$ for a single sphere, as given by    @  ( 
%eq:repulsive-gradient \@@italiccorr ).
function [gradURep]=potential_repulsiveSphereGrad(xEval,sphere)

%This function must use the outputs of sphere_distanceSphere.


%  sphere = struct('xCenter', [1;2], 'radius', 4, 'distInfluence', 2);
%  points = [1,2,4,5; 4,2,5,1];
%  xEval = [5;5];

% Initialize Variables
d_influence = sphere.distInfluence;


% find signed dist b/w point and sphere surface
dPointsSphere = sphere_distance(sphere,xEval);


% find gradient of signed distance
gradDPointsSphere = sphere_distanceGrad(sphere, xEval);


% Urep evaluated at x = xEval
switch true
    case dPointsSphere > 0 && dPointsSphere < d_influence
         gradURep = -((1/dPointsSphere)-(1/d_influence))*(1/dPointsSphere^2)*gradDPointsSphere;

    case dPointsSphere <= 0
         gradURep = NaN(2,1);

    otherwise 
        gradURep = [0;0];
end

end



