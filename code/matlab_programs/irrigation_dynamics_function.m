function [x1_next, x2_next]=irrigation_dynamics_function(x1_act, x2_act, ir_act, eto_act, Kc  )
% Loop to show plant dynamics, plot during loop
% Input: x1_act, x2_act, ir_act, eto_act, Kc
% Outputs: x1_next, x2_next

% Define a second order model for plant dynamics
A_above=   [ 0.98501           0.00001; 
             0.00001           0.98491       ];   
A_middle=  [ 1.00000           0.00001; 
             0.00001           0.98495       ];   
A_below=   [ 1.00000           0.00001; 
             0.00001           0.98488       ];   


B_above=   [ 0.00245          -0.00004; 
             0.00300          -0.00020  ];   
B_middle=  [ 0.00135          -0.00060; 
             0.00325          -0.00050  ];   
B_below=   [ 0.00125          -0.00005; 
             0.00150          -0.00035  ];   

C=         [ 1                0              ];

% Simulation global variables
high_limit=7.0;
low_limit=-7.0;
high_threshold=5.0;
low_threshold=-5.0;

% Create vectors
xk_act=[x1_act; x2_act];
uk_act=[ir_act; Kc*eto_act];
        
% Select state model according to sm level
if xk_act(1) > (high_threshold)
    xk_next=A_above*xk_act+B_above*uk_act;
elseif xk_act(1) > (low_threshold)
    xk_next=A_middle*xk_act+B_middle*uk_act;
else
    xk_next=A_below*xk_act+B_below*uk_act;
end

% Plant dynamics doesn´t go beyond limits
if( xk_next(1)>(high_limit))
    xk_next(1)=high_limit;
end
if( xk_next(1)<(low_limit))
    xk_next(1)=low_limit;
end

% Return values
x1_next=xk_next(1);
x2_next=xk_next(2);
