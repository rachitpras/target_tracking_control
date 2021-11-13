function traj_planned = planner_linear(time)
    vel_UAV = 1.0;
    del_t = 2.0;
    dt = 0.01;

    start = [10.0, 10.0, 10.0];
    goal = [30.0, 90.0, 10.0];

    dir_vec = (goal - start)/norm(goal - start);

    t_vec = (0:dt:del_t) + time;
    traj_planned = zeros(length(t_vec),4);
    traj_planned(:,1) = t_vec;
    traj_planned(:,2) = start(1) + vel_UAV*dir_vec(1)*t_vec;
    traj_planned(:,3) = start(2) + vel_UAV*dir_vec(2)*t_vec;
    traj_planned(:,4) = start(3) + vel_UAV*dir_vec(3)*t_vec;
    
end

