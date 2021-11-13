function traj_planned = planner_curved(time)
    vel_UAV = 1.0;
    del_t = 2.0;
    dt = 0.01;
    freq = 2*pi/100.0;

    start = [10.0, 10.0, 10.0];
    goal = [30.0, 90.0, 10.0];

    dir_vec = (goal - start)/norm(goal - start);
    angle = atan(dir_vec(2)/dir_vec(1));

    t_vec = (0:dt:del_t) + time;
    traj_planned = zeros(length(t_vec),4);
    traj_planned(:,1) = t_vec;
    traj_planned(:,2) = start(1) + vel_UAV*cos(angle)*t_vec;
    traj_planned(:,3) = start(2) + 2.5*vel_UAV*sin(freq*t_vec)*sin(angle);
    traj_planned(:,4) = start(3);
    
end

