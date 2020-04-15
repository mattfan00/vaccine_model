city1=[]; % the United States
city2=[]; % China
totalInfections=[];
N=[8004878 33975610]; % populations of USA and China respectively

%SIR model
S=[8004878 33975609]; 
I=[0 1];
R=[0 0];

%reproduction number a/b = 2.5
a=1/2;
b=1/10;
T=100; % with units days
dt=0.1;
clockmax=ceil(T/dt);

% exchange rates - percentage of population every day
e1=0.00000105845; % people traveling out of USA and going into China
e2=0.00000308686; % people traveling out of China and going into USA
for i = 1:clockmax
    t=i*dt;
    
    S=S-dt*a*S.*I./N;
    I=I+dt*(a*I.*S./N-b*I);
    R=R+dt*b*I;
    
    
    SS=S(1);
    II=I(1);
    RR=R(1);
    
    % showing a travel ban after 10 days
    if t < 10
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
    end
    
    population = S(1)+S(2)+I(1)+I(2)+R(1)+R(2);
    
    city1(i,:)=[t S(1) I(1) R(1)];
    city2(i,:)=[t S(2) I(2) R(2)];
    totalInfections(i,:)=[t I(1)+I(2)];
    
end
%set the figure window title
figure('Name','Travel restrictions implemented','NumberTitle','off') 
for j = 2:4
    subplot(3,1,1)
    plot (city1(:,1),city1(:,j),'-o');
    title ('USA with Travel Ban');
    hold on
end
legend('S', 'I', 'R');

for j = 2:4
    subplot(3,1,2)
    plot (city2(:,1),city2(:,j),'-o');
    title ('China with Travel Ban');
    hold on
end
legend('S', 'I', 'R');

subplot(3,1,3);
plot (totalInfections(:,1), totalInfections(:,2), '-o');
title ('Total Infections with Travel Ban'); 
hold on
