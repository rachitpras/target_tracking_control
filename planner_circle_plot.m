function traj_planned = planner_circle_plot(t_max)
    vel_UAV = 1.0;
    dt = 0.01;
    freq = 2*pi/100.0;

    t_vec = 0:dt:t_max;
    traj_planned = zeros(length(t_vec),4);
    start = [20.0; 20.0 + 50.0/pi; 10.0];
    for i=1:length(t_vec)
        if(t_vec(i)<100.0)
            traj_planned(i,1) = t_vec(i);
            traj_planned(i,2) = start(1) + sin(freq*t_vec(i))*vel_UAV/freq;
            traj_planned(i,3) = start(2) + (1.0-cos(freq*t_vec(i)))*vel_UAV/freq;
            traj_planned(i,4) = 10.0;
        else
            traj_planned(i,1) = t_vec(i);
            traj_planned(i,2) = start(1) + sin(freq*t_vec(i))*vel_UAV/freq;
            traj_planned(i,3) = start(2) - (1.0-cos(freq*t_vec(i)))*vel_UAV/freq;
            traj_planned(i,4) = 10.0;
        end
    end
end

