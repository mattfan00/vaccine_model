N=10000;%population

S=9999; %inital value for S
I=1; %Patient Zero
R=0;

SR=0; %number of susceptible people that recovered because of vaccine
IR=0; %number of people that were recovered from infection

a=1/2; %infectious rate
b=1/5; %recovery rate
v=1/100; %vaccination rate
T=300; %with units days
dt=1/8; %dt
clockmax=ceil(T/dt);
overall = zeros(clockmax, 4); % array that keeps track of t, S, I, R at every single loop
split = zeros(clockmax, 5); % array that keeps track of t, S, I, IR, SR at every single loop

for i = 1:clockmax
    t=i*dt;
    if t < 10 % this is the day that the vaccine will be released
        v=0;
    else
        v=1/100;
    end
    SS=S;
    S=S+dt*(-a*S*I/N-S*v); %number of susceptible people going down because of infection and vaccination
    
    II=I;
    I=I+dt*(a*I*SS/N-b*I);    
    
%     R=R+dt*(b*II+SS*v);
    IR=IR+dt*(b*II);
    SR=SR+dt*(SS*v);
    
    R=IR+SR;
    
    overall(i,:)=[t S I R]; 
    split(i,:)=[t S I IR SR];

end
% figure

for j = 2 : 4
    subplot(3,1,1);
    plot (overall(:,1),overall(:,j),'-o');
    axis ([0 100 0 10000])
    title('Line plot of SIR model with delayed vaccines')
    hold on
end
legend('S','I','R')

for j = 2 : 5
    subplot(3,1,2);
    plot (split(:,1),split(:,j),'-o');
    axis ([0 100 0 10000])
    title('Line plot showing vaccined-recovered and infected-recovered')
    hold on
end
legend('S','I','IR','SR')
for j = 2 : 5
    subplot(3,1,3);
    plot (split(:,1),split(:,j),'-o');
    axis ([0 300 0 10000])
    title('Line plot showing the full 300 days')
    hold on
end
legend('S','I','IR','SR')