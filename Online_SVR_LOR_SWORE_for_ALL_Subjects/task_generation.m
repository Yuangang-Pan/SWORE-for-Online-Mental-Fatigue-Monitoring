function pairwise_comparison = task_generation(RT)
%% RT: response time
pairwise_comparison = [];

[order_RT(:,1), id] = sort(RT);
for i = 1 : length(id)
    t1 = sum(order_RT(:,1) < min(order_RT(i,1)+0.15, 1.2*order_RT(i,1)))+1;
    t2 = sum(order_RT(:,1) < min(order_RT(i,1)+0.3, 1.4*order_RT(i,1)))+1;
    order_RT(i,2) = t1; % equal
    order_RT(i,3) = t2; % greater
end
%% generate the pairwise comparisions
t = 1;
for i = 1 : length(id)-1
    for j = i+1 : (order_RT(i,2) - 1)
        pairwise_comparison(t,:) = [0, id(i), id(j)];
        t = t+1;
    end
end

for i = 1 : length(id)-1
    for j = order_RT(i,3) : length(id)
        pairwise_comparison(t,:) = [1, id(j), id(i)];
        t = t+1;
    end
end
