function traj_planned = planner_circle(time)
    vel_UAV = 1.0;
    del_t = 2.0;
    dt = 0.01;
    freq = 2*pi/100.0;

    if(time<100)
        start = [20.0; 20.0 + 50.0/pi; 10.0];
        t_vec = (0:dt:del_t) + time;
        traj_planned = zeros(length(t_vec),4);
        traj_planned(:,1) = t_vec;
        traj_planned(:,2) = start(1) + sin(freq*t_vec)*vel_UAV/freq;
        traj_planned(:,3) = start(2) + (1.0-cos(freq*t_vec))*vel_UAV/freq;
        traj_planned(:,4) = 10.0;
    else
        start = [20.0; 20.0 + 50.0/pi; 10.0];
        t_vec = (0:dt:del_t) + time;
        traj_planned = zeros(length(t_vec),4);
        traj_planned(:,1) = t_vec;
        traj_planned(:,2) = start(1) + sin(freq*t_vec)*vel_UAV/freq;
        traj_planned(:,3) = start(2) - (1.0-cos(freq*t_vec))*vel_UAV/freq;
        traj_planned(:,4) = 10.0;   
     end
    
end

