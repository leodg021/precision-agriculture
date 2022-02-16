% Area 1 Simulation
clear all
clc

% Initialize Area 1 variables
area(1).x1_initial=0.0;
area(1).x2_initial=0.0;
area(1).xk_array=[];
area(1).ir_array=[0];
area(1).Kc=1.4;
area(1).control_high=6;
area(1).control_low=-6;
area(1).irrigation_value=45.0;

% Initialize common variables
eto_array=[];
t_array=[];

% Obtain eto_array and determine simulation period (45 days)
load('DataSet_ETO_45_days.mat');
simulation_period=length(eto_array);

for t=1:1:simulation_period
    % -------------------------------------------------------------------------------------------
    % AREA 1
    % -------------------------------------------------------------------------------------------
    % Process dynamics
    [x1_next, x2_next]=irrigation_dynamics_function(area(1).x1_initial, area(1).x2_initial, ...
                                               area(1).ir_array(t), eto_array(t), area(1).Kc  );
    area(1).x1_initial=x1_next;
    area(1).x2_initial=x2_next;
    area(1).xk_array(t,1)=x1_next;
    area(1).xk_array(t,2)=x2_next;

    % Control action
    if( x1_next > area(1).control_high )
        area(1).ir_array(t+1,1)=0.0;
    elseif( x1_next < area(1).control_low )
        area(1).ir_array(t+1,1)=area(1).irrigation_value;
    else
        area(1).ir_array(t+1,1)=area(1).ir_array(t);
    end
   
    t_array=[t_array; t];
end

% -------------------------------------------------------------------------------------------
% Plot results Area 1
% -------------------------------------------------------------------------------------------
figure(1)
hold on
subplot(3,1,1);
plot(t_array,area(1).xk_array(:,1),'b-',t_array,zeros(simulation_period,1),'k--',...
                                t_array,area(1).control_high*ones(simulation_period,1),'k:',...
                                t_array,area(1).control_low*ones(simulation_period,1),'k:');
hold off
axis([0 simulation_period -8 8]);
datetick('x','HH','keeplimits');

subplot(3,1,2);
stairs(t_array,area(1).ir_array(1:simulation_period),'r-');
axis([0 simulation_period 0 50]);
datetick('x','HH','keeplimits');

subplot(3,1,3);
plot(t_array,eto_array,'g-');
axis([0 simulation_period 0 20]);
datetick('x','HH','keeplimits');

