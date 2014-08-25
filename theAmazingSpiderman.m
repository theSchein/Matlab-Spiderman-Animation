close all, clear all, clc

%% Setting the scene: THE AMAZING SPIDERMAN
% this code depicts an epic scene featuring the famous spiderman as he
% tries to save his Mary Jane Watson's life. This time the user gets to
% decide on some key peices to the scene. These pieces include the color of
% spiderman's suit, whether the building is on fire, and even if spiderman
% can save Mary Jane. In order to run the code just click run and type
% 'yes'or 'no' to any of the three questions.
disp('Mary Jane Watson has been dropped from a building by the green goblin.'); 
disp( 'She is falling to her death and only Spiderman can save her!');

%% Background
%Scope
Axes = axes('XLim',[-90 20],'YLim',[-30 30],...
    'Zlim', [0 70]);
view(3);
grid on;  
axis equal;
hold on
xlabel('x');
ylabel('y');
zlabel('z');
[x y z] = cylinder([0.2 0.2]); % used on spiderman and mary jane
[i j k]= sphere; % used on spidermans and mary janes head
[xc yc zc] = cylinder([0.1 0.0]); % used for the fire on the buildings
% the axis appears before the user input is requested so that the user can
% dock the empty plot before anything actually happens.

%% user input
color = input('Is this spiderman 3?      ', 's');
fire = input('Is the building on fire?    ', 's');
save = input('Does Spiderman save Mary Jane?    ', 's');

switch  color % this part changes the varible used to color spiderman
    case {'y','Y', 'yes', 'yeah', 'YES'};
        spidermanColor = 'black';
    otherwise 
        spidermanColor = 'red';
end
switch fire % when switched yes randomly generated cones appear on mary js building
    case {'y', 'Y', 'yes', 'yeah', 'sure', 'YES'};
        i=0  ;
       while i< 50;
        fire= surface( (0+20)*rand(1,1)*xc+(0+20*rand(1,1)), (0+20)*rand(1,1)*yc+(0+20*rand(1,1)),...
            (1+30)*rand(1,1)*zc+60, 'Facecolor', [1 rand(1) 0]);
        i=i+1;
        hold on
       end
        
end
switch save; % this switch alters spidermans path
    case { 'no', 'n', 'NOPE', 'N', 'NO'};
        omegaX = .10*pi;
        omegaZ = -.074*pi;
    otherwise
        omegaX= .16*pi;
        omegaZ= -.074*pi;
end

%% Buildings

% Mary J building
southFacade1= surface(50*x+10, 0*y, 60*z);
eastFacade1= surface(0*x+20, 50*y+10,60*z);
northFacade1= surface(50*x+10, 0*y+20, 60*z);
westFacade1= surface(0*x, 50*y+10,60*z);
topFacade1= surface(50*x+10,20*z,0*y+60, 'Facecolor', 'black');
% the building is a collection of square planes. It does not need to be
% combined as one object because it is not moving

% Spiderman Building
southFacade2= surface(50*x-70, 0*y, 60*z);
eastFacade2= surface(0*x-60, 50*y+10,60*z);
northFacade2= surface(50*x-70, 0*y+20, 60*z);
westFacade2= surface(0*x-80, 50*y+10,60*z);
topFacade2= surface(50*x-70,20*z,0*y+60, 'Facecolor', 'black');
% this building is the same as the first except moved more towards
% spiderman.  

%% Mary Jane Watson Generation
[i j k]= sphere;
% Each surface of the woman
h(1)= surface(.5*i-5, .5*j, .5*k+65, 'Facecolor', 'yellow');
h(2)= surface(2*x-5, 0*y-.5, 2*z+64.4, 'Facecolor', 'red');
h(3)= surface(2*x-5, 3*z, y+65, 'Facecolor', 'green');
h(4)= surface(1*x-5.27, 2*z+2.5, y+65, 'Facecolor', 'blue');
h(5)= surface(1*x-4.73, 2*z+2.5, y+65, 'Facecolor', 'blue');
h(6)= surface(1*x-5.27, 2*y+1, z+65, 'Facecolor', 'green');
h(7)= surface(1*x-4.73, 2*y+1, z+65, 'Facecolor', 'green');
% setting each surface to one object
maryJ = hgtransform('Parent',Axes);
set(h(1:7), 'Parent', maryJ); 
drawnow

%% Spiderman Creation

h(8)= surface(.5*i-60, .5*j+2, .5*k+64, 'Facecolor', spidermanColor);
h(9)= surface(1.5*x-60, 1.5*y+2, 2*z+62, 'Facecolor', spidermanColor);
h(10)= surface(.75*x-60, .75*y+2.2, 1.5*z+60.5,'Facecolor', spidermanColor);
h(11)= surface(.75*x-60, .75*y+1.8, 1.5*z+60.5,'Facecolor', spidermanColor);
h(12)= surface(z-60.2, .75*y+2.2, .75*x+63.25,'Facecolor', spidermanColor);
h(13)= surface(z-59.8, .75*y+1.8, .75*x+63.25,'Facecolor', spidermanColor);

%setting ech surface to one object
spiderman = hgtransform('Parent',Axes);
set(h(8:13), 'Parent', spiderman); 
drawnow


%% Mary J and Spiderman path

% constants
acceleration= -9.81; % m/s/s acceleration due to gravity
t=0; % interval will be used in the loop
Ax= -55; % Spiderman x-direction
fiX= pi;
Az= -65; 
fiZ= pi/2; % Spiderman z-direction

while t < 4;
   % Mary Jane falling motion
    d=.5*acceleration*t^2;
        translation1 = makehgtform('translate',...
        [0 0 d]);
    set(maryJ,'Matrix',...
        translation1*1);
    t= t+.005;
    pause(.0003) % can be altered for a more dramatic expierence. removing 
                 % the pause will result in real-time.
  % Spiderman swinging
     xd = Ax*sin(t*omegaX+ fiX); % Pendulum physics
     zd = Az*cos(t*omegaZ+ fiZ); % Spiderman movement is not affected by 
                                 % gravity but instead what I would call 'superhero' physics 
     translation2=  makehgtform('translate',...
        [xd 0 zd]);
         set(spiderman,'Matrix',...
        translation2)
    if xd >= 54.8;
        disp('Mary J is saved!!!')
        t= 5;
    end
     if d < -65;
       disp('That bitch is dead');
       t = 5;
   end
end
