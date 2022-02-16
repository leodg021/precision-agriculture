% Multiple Areas Simulation
clear all
clc

% Initialize Area 1 variables
area(1).x1_initial=5.0;
area(1).x2_initial=0.0;
area(1).xk_array=[];
area(1).ir_array=[0];
area(1).Kc=1.0;
area(1).control_high=5;
area(1).control_low=-5;
area(1).irrigation_value=40.0;
area(1).sensor_delay=80;

% Initialize Area 2 variables
area(2).x1_initial=-5.0;
area(2).x2_initial=0.0;
area(2).Kc=1.2;
area(2).xk_array=[];
area(2).ir_array=[0];
area(2).control_high=1;
area(2).control_low=-1;
area(2).irrigation_value=45.0;
area(2).sensor_delay=100;

% Initialize Area 3 variables
area(3).x1_initial=2.0;
area(3).x2_initial=0.0;
area(3).Kc=1.4;
area(3).xk_array=[];
area(3).ir_array=[0];
area(3).control_high=2;
area(3).control_low=-2;
area(3).irrigation_value=35.0;
area(3).sensor_delay=80;

% Initialize Area 4 variables
area(4).x1_initial=-2.0;
area(4).x2_initial=0.0;
area(4).Kc=0.8;
area(4).xk_array=[];
area(4).ir_array=[0];
area(4).control_high=4;
area(4).control_low=-4;
area(4).irrigation_value=40.0;
area(4).sensor_delay=60;

% Initialize common variables
eto_array=[];
t_array=[];
counter=0;

% Obtain eto_array and determine simulation period (45 days)
load('DataSet_ETO_45_days.mat');
simulation_period=length(eto_array);

for t=1:1:simulation_period
    % -------------------------------------------------------------------------------------------
    % AREA 1
    % -------------------------------------------------------------------------------------------
    % Soil moisture sensor delay
     if( t > area(1).sensor_delay )
        effective_ir=area(1).ir_array(t-area(1).sensor_delay);
    else
        effective_ir=area(1).ir_array(1);
     end
     
    % Process dynamics
    [x1_next, x2_next]=irrigation_dynamics_function(area(1).x1_initial, area(1).x2_initial, ...
                                               effective_ir, eto_array(t), area(1).Kc  );
    area(1).x1_initial=x1_next;
    area(1).x2_initial=x2_next;
    area(1).xk_array(t,1)=x1_next;
    area(1).xk_array(t,2)=x2_next;

    % Control action
    if( x1_next > area(1).control_high )
        area(1).ir_array(t+1,1)=0.0;
    elseif( x1_next < area(1).control_low && area(2).ir_array(t)==0 && area(3).ir_array(t)==0 && area(4).ir_array(t)==0 )
        area(1).ir_array(t+1,1)=area(1).irrigation_value;
    else
        area(1).ir_array(t+1,1)=area(1).ir_array(t);
    end
    
    % -------------------------------------------------------------------------------------------
    % AREA 2
    % -------------------------------------------------------------------------------------------
    % Soil moisture sensor delay
     if( t > area(2).sensor_delay )
        effective_ir=area(2).ir_array(t-area(2).sensor_delay);
     else
        effective_ir=area(2).ir_array(1);
     end
     
     % Process dynamics
    [x1_next, x2_next]=irrigation_dynamics_function(area(2).x1_initial, area(2).x2_initial, ...
                                               effective_ir, eto_array(t), area(2).Kc  );
    area(2).x1_initial=x1_next;
    area(2).x2_initial=x2_next;
    area(2).xk_array(t,1)=x1_next;
    area(2).xk_array(t,2)=x2_next;

    % Control action
    if( x1_next > area(2).control_high )
        area(2).ir_array(t+1,1)=0.0;
    elseif( x1_next < area(2).control_low && area(1).ir_array(t+1)==0 && area(3).ir_array(t)==0 && area(4).ir_array(t)==0)
        area(2).ir_array(t+1,1)=area(2).irrigation_value;
    else
        area(2).ir_array(t+1,1)=area(2).ir_array(t,1);
    end
    
    % -------------------------------------------------------------------------------------------
    % AREA 3
    % -------------------------------------------------------------------------------------------
    % Soil moisture sensor delay
     if( t > area(3).sensor_delay )
        effective_ir=area(3).ir_array(t-area(3).sensor_delay);
     else
        effective_ir=area(3).ir_array(1);
     end
     
    % Process dynamics
    [x1_next, x2_next]=irrigation_dynamics_function(area(3).x1_initial, area(3).x2_initial, ...
                                               effective_ir, eto_array(t), area(3).Kc  );
    area(3).x1_initial=x1_next;
    area(3).x2_initial=x2_next;
    area(3).xk_array(t,1)=x1_next;
    area(3).xk_array(t,2)=x2_next;

    % Control action
    if( x1_next > area(3).control_high )
        area(3).ir_array(t+1,1)=0.0;
    elseif( x1_next < area(3).control_low && area(1).ir_array(t+1)==0 && area(2).ir_array(t+1)==0 && area(4).ir_array(t)==0)
        area(3).ir_array(t+1,1)=area(3).irrigation_value;
    else
        area(3).ir_array(t+1,1)=area(3).ir_array(t,1);
    end
    
    % -------------------------------------------------------------------------------------------
    % AREA 4
    % -------------------------------------------------------------------------------------------
    % Soil moisture sensor delay
     if( t > area(4).sensor_delay )
        effective_ir=area(4).ir_array(t-area(4).sensor_delay);
     else
        effective_ir=area(4).ir_array(1);
     end
     
    % Process dynamics
    [x1_next, x2_next]=irrigation_dynamics_function(area(4).x1_initial, area(4).x2_initial, ...
                                               effective_ir, eto_array(t), area(4).Kc  );
    area(4).x1_initial=x1_next;
    area(4).x2_initial=x2_next;
    area(4).xk_array(t,1)=x1_next;
    area(4).xk_array(t,2)=x2_next;

    % Control action
    if( x1_next > area(4).control_high )
        area(4).ir_array(t+1,1)=0.0;
    elseif( x1_next < area(4).control_low && area(1).ir_array(t+1)==0 && area(2).ir_array(t+1)==0 && area(3).ir_array(t+1)==0)
        area(4).ir_array(t+1,1)=area(4).irrigation_value;
    else
        area(4).ir_array(t+1,1)=area(4).ir_array(t,1);
    end
    
    % -------------------------------------------------------------------------------------------
    % COMMON
    % -------------------------------------------------------------------------------------------
    ir_array=area(1).ir_array(t+1,1)+area(2).ir_array(t+1,1)+area(3).ir_array(t+1,1)+area(4).ir_array(t+1,1);
    if( ir_array > 50.0 )
        counter=counter+1;
    end
    t_array=[t_array; t];
end
disp(counter);

% -------------------------------------------------------------------------------------------
% Plot results Area 1
% -------------------------------------------------------------------------------------------
figure(1)
subplot(4,1,1);
hold on
plot(t_array,area(1).xk_array(:,1),'b-',t_array,zeros(simulation_period,1),'k--',...
                                t_array,area(1).control_high*ones(simulation_period,1),'k:',...
                                t_array,area(1).control_low*ones(simulation_period,1),'k:');
%stairs(t_array,area(1).ir_array(1:simulation_period),'r-');
hold off
axis([0 simulation_period -8 8]);
datetick('x','HH','keeplimits');

% -------------------------------------------------------------------------------------------
% Plot results Area 2
% -------------------------------------------------------------------------------------------
subplot(4,1,2);
hold on
plot(t_array,area(2).xk_array(:,1),'b-',t_array,zeros(simulation_period,1),'k--',...
                                t_array,area(2).control_high*ones(simulation_period,1),'k:',...
                                t_array,area(2).control_low*ones(simulation_period,1),'k:');
%stairs(t_array,area(2).ir_array(1:simulation_period),'r-');
hold off
axis([0 simulation_period -8 8]);
datetick('x','HH','keeplimits');

% -------------------------------------------------------------------------------------------
% Plot results Area 3
% -------------------------------------------------------------------------------------------
subplot(4,1,3);
hold on
plot(t_array,area(3).xk_array(:,1),'b-',t_array,zeros(simulation_period,1),'k--',...
                                t_array,area(3).control_high*ones(simulation_period,1),'k:',...
                                t_array,area(3).control_low*ones(simulation_period,1),'k:');
%stairs(t_array,area(3).ir_array(1:simulation_period),'r-');
hold off
axis([0 simulation_period -8 8]);
datetick('x','HH','keeplimits');

% -------------------------------------------------------------------------------------------
% Plot results Area 4
% -------------------------------------------------------------------------------------------
subplot(4,1,4);
hold on
plot(t_array,area(4).xk_array(:,1),'b-',t_array,zeros(simulation_period,1),'k--',...
                                t_array,area(4).control_high*ones(simulation_period,1),'k:',...
                                t_array,area(4).control_low*ones(simulation_period,1),'k:');
%stairs(t_array,area(4).ir_array(1:simulation_period),'r-');
hold off
axis([0 simulation_period -8 8]);
datetick('x','HH','keeplimits');

