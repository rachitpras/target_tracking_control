clc; clear all;

vel_UAV = 2.0;
del_t = 2.0;
realTime = 0.0;
t_max = 66.0;

traj_planned = planner_curved(realTime);
[traj_actual, des] = init_PD_controller(traj_planned);

start=[traj_actual(end,2,:) traj_actual(end,3,:) traj_actual(end,4,:)];
traj_actual_total = traj_actual;
traj_planned_total = traj_planned;

realTime = realTime + del_t;
j = 1;

v = VideoWriter('nDrones_curved.avi');
v.FrameRate = 10;
open(v);
minDistanceHist = [];

traj_planned_plot = planner_curved_plot(t_max);
while(realTime<t_max)
    
    % Call the planner to plan trajectory
    [traj_planned] = planner_curved(realTime);
    
    % Call the controller to track the planned trajectory
    traj_actual = PD_controller(traj_planned, traj_actual(end,:,:), des);
    traj_actual_total = [traj_actual_total; traj_actual];
    traj_planned_total = [traj_planned_total; traj_planned];
    
    realTime = realTime + del_t;
    
    figure;
    plot3(traj_actual_total(:,2),traj_actual_total(:,3),traj_actual_total(:,4),'-b');
    hold on;
     
    grid on;
%     %view(0,90);
    axis([10.0 30.0 5.0 15.0 5.0 15.0]);
    
    plot3(traj_actual(end,2),traj_actual(end,3),traj_actual(end,4),'ob');
    plot3(traj_planned_plot(:,2),traj_planned_plot(:,3),traj_planned_plot(:,4),'--r');
%     temp=[traj_planned(end,2,iDrone) traj_planned(end,3,iDrone) traj_planned(end,4,iDrone)];
    start=[traj_actual(end,2) traj_actual(end,3) traj_actual(end,4)];

     
    F(j) = getframe;
        
    writeVideo(v,F(j));
    close;
     j=j+1;
     disp(realTime);
end

%cylProp = getObsTrajectory(realTime,obsProp);

movie(F,1,3);
close(v);

