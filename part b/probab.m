function [probability,reward] = probab(s1,s2,c1,c2,chg,req1,req2,ret1,ret2,day,max_cars)
%PROBAB Summary of this function goes here
%   Detailed explanation goes here

t1 = s1 - chg;
t2 = s2 + chg;

if chg == 1
    reward = 0;
else
    reward = -2*abs(chg);
end
if t1 >10 && day<=5
    reward = reward -4;
end
if t2>10 && day <=5
    reward = reward -4;
end
prob = 0;
reward_list = zeros(1,22);
for i = max(0,t1-c1):t1
   rented = i;
   returned = i+c1-t1;
   if c1 ==max_cars
       curr_prob = req1(rented+1)*sum(ret1(returned+1:max_cars +1));
   else
       curr_prob = req1(rented+1)*ret1(returned+1);
   end
   prob = prob + curr_prob;
   reward_list(i+1) = curr_prob*10*rented; 
    
end
if c1 ==max_cars
    curr_prob = sum(req1(t1+2:max_cars +1))*sum(ret1(c1+1:max_cars +1));
else
    curr_prob = sum(req1(t1+2:max_cars +1))*ret1(c1+1);
end
prob = prob + curr_prob;
reward_list(22) = curr_prob*10*t1;
reward = reward + sum(reward_list/prob);

prob2 = 0;
reward_list = zeros(1,22);
for j =max(0,t2-c2):t2
   rented = j;
   returned = j+c2-t2;
   if c2==max_cars
       curr_prob = req2(rented+1)*sum(ret2(returned+1:max_cars +1));
   else
       curr_prob = req2(rented+1)*ret2(returned+1);
   end
   prob2 = prob2 + curr_prob;
   reward_list(j+1) = curr_prob*10*rented; 
end
if c2==max_cars
    curr_prob = sum(req2(t2+2:max_cars +1))*sum(ret2(c2+1:max_cars +1));
else
    curr_prob = sum(req2(t2+2:max_cars +1))*ret2(c2+1);
end
prob2 = prob2 + curr_prob;
reward_list(22) = curr_prob*10*t2;

reward = reward + sum(reward_list/prob2);

probability = prob*prob2;

end

