function [final_dirn] = improv(s1,s2,req1,req2,ret1,ret2,gamma,V)
%IMPROV Summary of this function goes here
%   Detailed explanation goes here
max_v = 0;
change = 0;
for chg = -5:5
    if s1-chg >=0  &&s2+chg>=0
        if s2+chg<=20 && s1-chg<=20
            v = 0;
            for c1 = 0:20
                for c2 = 0:20
                    %next state is c1,c2                      
                    [probability,reward] = probab(s1,s2,c1,c2,chg,req1,req2,ret1,ret2);
                    v = v +probability*(reward+gamma*V(c1+1,c2+1));
                end
            end
            
            if v > max_v 
                change = chg;
                max_v = v;
            end
        end
    end
end
        

final_dirn = change;

end

