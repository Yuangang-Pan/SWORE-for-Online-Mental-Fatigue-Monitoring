function pairwise_comparison = MC_LOR_task_generation(RT)
%% RT: response time
pairwise_comparison = [];

[order_RT(:,1), id] = sort(RT);
t = 1;
for i = 1 : length(id)-1
    for j = i+1 : length(id)
        pairwise_comparison(t,:) = [1, id(j), id(i)];
        t = t+1;
    end
end
