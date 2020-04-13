city1=[]; % the United States
city2=[]; % China
totalInfections=[];
N=[235606 1000000]; % populations of USA and China respectively

%SIR model
S=[235606 998000]; 
I=[0 2000];
R=[0 0];

a=1/2;
b=1/10;
T=100; % with units days
dt=1/8;
clockmax=ceil(T/dt);

% exchange rates - percentage of population every day
e1=0.0001; % people traveling out of USA and going into China
e2=.0003; % people traveling out of China and going into USA
for i = 1:clockmax
    t=i*dt;
    
    S=S-dt*a*S.*I./N;
    I=I+dt*(a*I.*S./N-b*I);
    R=R+dt*b*I;
    
    
    SS=S(1);
    II=I(1);
    RR=R(1);
    
    % updating the population of city one of people leaving and people
    % coming in 
    S(1)=S(1)+(-e1*S(1)+e2*S(2))*dt;
    I(1)=I(1)+(-e1*I(1)+e2*I(2))*dt;
    R(1)=R(1)+(-e1*R(1)+e2*R(2))*dt;

    % updating the population of city two of people leaving and people
    % coming in 
    S(2)=S(2)+(-e2*S(2)+e1*SS)*dt;
    I(2)=I(2)+(-e2*I(2)+e1*II)*dt;
    R(2)=R(2)+(-e2*R(2)+e1*RR)*dt;
    
    population = S(1)+S(2)+I(1)+I(2)+R(1)+R(2);
    
    city1(i,:)=[t S(1) I(1) R(1)];
    city2(i,:)=[t S(2) I(2) R(2)];
    totalInfections(i,:)=[t I(1)+I(2)];
    
end

for j = 2:4
    plot1 = subplot(3,1,1);
    plot (city1(:,1),city1(:,j),'-o');
    title ('USA');
    hold on
end
legend('S', 'I', 'R');

for j = 2:4
    plot2 = subplot(3,1,2);
    plot (city2(:,1),city2(:,j),'-o');
    title ('China');
    hold on
end
legend('S', 'I', 'R');

plot3 = subplot(3,1,3);
plot (totalInfections(:,1), totalInfections(:,2), '-o');
title ('Total Infections'); 
hold on

% linkaxes([plot1 plot2 plot3],'y')
