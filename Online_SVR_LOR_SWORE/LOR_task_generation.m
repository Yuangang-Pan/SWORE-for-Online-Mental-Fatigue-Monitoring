function pairwise_comparison = LOR_task_generation(RT)
%% RT: response time
pairwise_comparison = [];

[order_RT(:,1), id] = sort(RT);
%% generate the pairwise comparisions
t = 1;
for i = 1 : length(id)-1
    for j = i+1 : length(id)
        pairwise_comparison(t,:) = [1, id(i), id(j)];
        t = t+1;
    end
end
