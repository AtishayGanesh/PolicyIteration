format long;
gamma = 0.9;
V = zeros(21);
P = zeros(21);
omega = 0.04;
x = 0:20;
req1 = poisspdf(x,3);
req2 = poisspdf(x,4);
ret1 = poisspdf(x,3);
ret2 = poisspdf(x,2);
req1(21) = 1 - sum(req1(1:20));
req2(21) = 1 - sum(req2(1:20));
ret1(21) = 1 - sum(ret1(1:20));
ret2(21) = 1 - sum(ret2(1:20));
counter =1;

while 1
    delta = 1;
    while delta> omega
        delta = 0;
        for s1 = 0:20
            for s2 = 0:20
               %state is s1,s1
               v = 0;
               chg = P(s1+1,s2+1);
               for c1 = 0:20
                   for c2 = 0:20
                       %next state is c1,c2
                       
                       [probability,reward] = probab(s1,s2,c1,c2,chg,req1,req2,ret1,ret2);
                       v = v +probability*(reward+gamma*V(c1+1,c2+1));
                   end
               end
               delta = max(delta,abs(v-V(s1+1,s2+1)));
               V(s1+1,s2+1)= v;
            end
        end 
        sprintf('Max Change is %f',delta)
    end
    
    
    %policy Improvement
    stable= 1;
    for s1 =0:20
        for s2 = 0:20
            %current state is s1,s2
            b = P(s1+1,s2+1);
            P(s1+1,s2+1) = improv(s1,s2,req1,req2,ret1,ret2,gamma,V);
            if b ~= P(s1+1,s2+1)
                stable =0;
            
            end
        end
    end
    figure(counter)
    contourf(0:20,0:20,P)
    title("Policy Chart");
    xlabel("Location 2 - Cars");
    colorbar
    ylabel("Location 1 - Cars");
    g = compose("%iiter.png",counter);
    saveas(gcf,g)
    counter = counter+1;
    if stable == 1
        break;
    end
    
    
end
