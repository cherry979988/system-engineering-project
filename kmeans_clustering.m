function [middle, label, err]=kmeans_clustering(data, num)
%% choose starting points
    N = size(data,1);
    dist = zeros(N,num);
    middle = zeros(num,size(data,2));
    for i=1:num
        middle(i,:)=data(i,:);
    end
        
%% iteration
    while(true)
        for i=1:N
            for j=1:num
                dist(i,j)=norm(data(i,:)-middle(j,:));
            end
        end
        [~,label] = min(dist,[],2);
        middle_old = middle;
        for j=1:num
            middle(j,:)=mean(data(label==j,:));
        end
        if(norm(middle_old-middle)<1e-1)
            err = 0;
            for i=1:size(data,1)
                err = err + norm(data(i,:)-middle(label(i),:));
            end
            break
        end
    end
    
 %% print out result
    % disp(middle)
end