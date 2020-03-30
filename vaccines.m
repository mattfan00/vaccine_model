N=10000;%population

S=9999; %inital value for S
I=1; %Patient Zero
R=0;

a=1/2; %infectious rate
b=1/5; %recovery rate
v=1/100; %vaccination rate
T=300; %with units days
dt=1/8; %dt
clockmax=ceil(T/dt);
event = zeros(clockmax, 4); % array that keeps track of t, S, I, R at every single loop

for i = 1:clockmax
    t=i*dt;
    
    SS=S;
    S=S+dt*(-a*S*I/N-S*v);
    
    II=I;
    I=I+dt*(a*I*SS/N-b*I);    
    
    R=R+dt*(b*II+SS*v);
    
    event(i,:)=[t S I R];
    
end
figure

for j = 2 : 4
    plot (event(:,1),event(:,j),'-o');
    hold on
end
legend('S','I','R')
