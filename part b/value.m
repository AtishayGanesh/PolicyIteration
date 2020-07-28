format long;
gamma = 0.9;
max_cars = 20;
V = zeros(max_cars+1,max_cars+1,7);
P = zeros(max_cars+1,max_cars+1,7);
omega = 0.04;
x = 0:max_cars;
req1 = poisspdf(x,3);
req2 = poisspdf(x,4);
ret1 = poisspdf(x,3);
ret2 = poisspdf(x,2);
req1(21) = 1 - sum(req1(1:max_cars));
req2(21) = 1 - sum(req2(1:max_cars));
ret1(21) = 1 - sum(ret1(1:max_cars));
ret2(21) = 1 - sum(ret2(1:max_cars));


while 1
    delta = 1;
    while delta> omega
        delta = 0;
        for day = 1:7
            for s1 = 0:max_cars
                for s2 = 0:max_cars
                   %state is s1,s1
                   v = 0;
                   chg = P(s1+1,s2+1,day);
                   for c1 = 0:max_cars
                       for c2 = 0:max_cars
                           %next state is c1,c2
                           [probability,reward] = probab(s1,s2,c1,c2,chg,req1,req2,ret1,ret2,day,max_cars);
                           v = v +probability*(reward+gamma*V(c1+1,c2+1,mod(day,7)+1 ));
                       end
                   end
                   delta = max(delta,abs(v-V(s1+1,s2+1,day)));
                   V(s1+1,s2+1,day)= v;
                end
            end
        end    
        sprintf('Max Change is %f',delta)
    end
    
    
    %policy Improvement
    stable= 1;
    for day = 1:7
        for s1 =0:max_cars
            for s2 = 0:max_cars
                %current state is s1,s2
                b = P(s1+1,s2+1,day);
                P(s1+1,s2+1,day) = improv(s1,s2,req1,req2,ret1,ret2,gamma,V,day,max_cars);
                if b ~= P(s1+1,s2+1,day)
                    stable =0;

                end
            end
        end
    end
    if stable == 1
        figure(1)
        contourf(0:max_cars,0:max_cars,P(:,:,1))
        title("Monday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar
        figure(2)
        contourf(0:max_cars,0:max_cars,P(:,:,2))
        title("Tuesday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar
        figure(3)
        contourf(0:max_cars,0:max_cars,P(:,:,3))
        title("Wednesday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar
        figure(4)
        contourf(0:max_cars,0:max_cars,P(:,:,4))
        title("Thursday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar
        figure(5)
        contourf(0:max_cars,0:max_cars,P(:,:,5))
        title("Friday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar
        figure(6)
        contourf(0:max_cars,0:max_cars,P(:,:,6))
        title("Saturday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar
        figure(7)
        contourf(0:max_cars,0:max_cars,P(:,:,7))
        title("Sunday Policy Chart")
        xlabel("Location 2 - Cars")
        ylabel("Location 1 - Cars")
        colorbar

        pause(10);
        break;
    end
    
    
end
