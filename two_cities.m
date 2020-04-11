city1=[];
city2=[];
N=[10000 10000] % population

S=[9995 10000]; 
I=[5 0];
R=[0 0];

a=1/3;
b=1/4;
T=100; % with units days
dt=1/8;
clockmax=ceil(T/dt);

e=0.1; % exchange rate - percentage of population every day
for i = 1:clockmax
    t=i*dt;
    
    S=S-dt*a*S.*I./N;
    I=I+dt*(a*I.*S./N-b*I);
    R=R+dt*b*I;
    
    
    SS=S(1);
    II=I(1);
    RR=R(1);
    
    if t > 50
        % updating the population of city one of people leaving and people
        % coming in 
        S(1)=S(1)+(-e*S(1)+e*S(2))*dt;
        I(1)=I(1)+(-e*I(1)+e*I(2))*dt;
        R(1)=R(1)+(-e*R(1)+e*R(2))*dt;

        % updating the population of city two of people leaving and people
        % coming in 
        S(2)=S(2)+(-e*S(2)+e*SS)*dt;
        I(2)=I(2)+(-e*I(2)+e*II)*dt;
        R(2)=R(2)+(-e*R(2)+e*RR )*dt;
    end
    
    city1(i,:)=[t S(1) I(1) R(1)];
    city2(i,:)=[t S(2) I(2) R(2)];
    
end

for j = 2:4
    subplot(2,1,1)
    plot (city1(:,1),city1(:,j),'-o');
    hold on
end
legend('S', 'I', 'R');

for j = 2:4
    subplot(2,1,2)
    plot (city2(:,1),city2(:,j),'-o');
    hold on
end
legend('S', 'I', 'R');
