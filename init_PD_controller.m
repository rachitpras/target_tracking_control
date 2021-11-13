function [traj_actual, des_return] = init_PD_controller(traj_planned)
%init_PD_controller
%   Implements the PD controller from initial conditions.

    addpath('utils');
    control_handle = @controller;
    params = sys_params;
    
% Set the paramemters to create minimum snap trajectories
    dt = traj_planned(2,1) - traj_planned(1,1);
    dt_wp = 0.5;
    n_skip = int32(dt_wp/dt);
    traj_wp = traj_planned(1:n_skip:end,:);
    
    n_poly = size(traj_wp,1)-1;
    nDim = 3;
    min_snap_coeffs = zeros(8*n_poly,3);
    

    for iDim = 1:nDim
        min_snap_coeffs(:,iDim) = calc_min_snap_coeffs_init(traj_wp(:,iDim+1));
    end

    % Controller in action
    max_time = 2.0;
    tstep = 0.01;
    des_return = zeros(3,3);    

    traj_handle = @(t) traj_gen(t, min_snap_coeffs);
    timeint = 0:tstep:max_time-tstep;
    des_start = traj_handle(timeint(1));
    des = traj_handle(timeint(end));

    des_return(1,:) = des.pos;
    des_return(2,:) = des.vel;
    des_return(3,:) = des.acc;

    x0    = init_state(des_start.pos, 0);

    [tsave, xsave] = ode45(@(t,s) quadEOM(t, s, control_handle, traj_handle, params), timeint, x0);


    traj_actual = cat(2,tsave, xsave);
        
end

