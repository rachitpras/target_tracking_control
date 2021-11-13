function [desired_state] = traj_gen(t,min_snap_coeffs)
%traj_gen
%   Function to generate trajectory from minimum snap coefficients

t_wp= 0.5;
n_wp = floor(t/t_wp);
t = mod(t,t_wp);
t = t/t_wp;

nDim = 3;
pos = zeros(nDim,1);
vel = zeros(nDim,1);
acc = zeros(nDim,1);
for iDim = 1:nDim
    coeffs = min_snap_coeffs(n_wp*8+1:(n_wp+1)*8,iDim);
    pos(iDim) = coeffs(1) + coeffs(2)*t + coeffs(3)*(t^2) + coeffs(4)*(t^3) + coeffs(5)*(t^4) + coeffs(6)*(t^5)+ coeffs(7)*(t^6) + coeffs(8)*(t^7);
    vel(iDim) = (coeffs(2) + 2*coeffs(3)*t + 3*coeffs(4)*(t^2) + 4*coeffs(5)*(t^3) + 5*coeffs(6)*(t^4)+ 6*coeffs(7)*(t^5) + 7*coeffs(8)*(t^6))/t_wp;
    acc(iDim) = (2*coeffs(3) + 6*coeffs(4)*t + 12*coeffs(5)*(t^2) + 20*coeffs(6)*(t^3)+ 30*coeffs(7)*(t^4) + 42*coeffs(8)*(t^5))/(t_wp^2);
end
desired_state.pos = pos;
desired_state.vel = vel;
desired_state.acc = acc;
desired_state.yaw = atan(vel(2)/vel(1));
desired_state.yawdot = 0;

end

