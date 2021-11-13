function traj_actual = PD_controller(traj_planned, state, des)
%init_PD_controller
%   Implements the PD controller from initial conditions.

    %addpath('utils');
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
        min_snap_coeffs(:,iDim) = calc_min_snap_coeffs(traj_wp(:,iDim+1), des(:,iDim));
    end

    % Controller in action
    max_time = 2.0;
    tstep = 0.01;
    timeint = 0:tstep:max_time-tstep;
    traj_actual = zeros(length(timeint), 13);
    t_actual = zeros(length(timeint), 1);

    traj_handle = @(t) traj_gen(t, min_snap_coeffs);

    %x0    = init_state(des_start.pos, 0);
    x0    = state(1,2:14);

%         pos = zeros(length(timeint),3);
%         vel = zeros(length(timeint),3);
%         acc = zeros(length(timeint),3);
%         
%         for i=1:length(timeint)
%             dd = traj_handle(timeint(i));
%             pos(i,:) = dd.pos;
%             vel(i,:) = dd.vel;
%             acc(i,:) = dd.acc;
%         end

    [tsave, xsave] = ode45(@(t,s) quadEOM(t, s, control_handle, traj_handle, params), timeint, x0);


    traj_actual = cat(2,tsave, xsave);
        
end

