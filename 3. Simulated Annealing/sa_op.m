function [F, X, value] = simulated_annealing()
    % Perform simulated annealing for optimization

    % Initialize arrays to store results
    F = zeros(1, 10);
    X = zeros(10, 2);

    % Iterate over 10 runs
    for k = 1:10
        % Initialize current solution randomly within the search space
        current_solution = rand(1,2) * (10.24) - 5.12;
        
        % Initialize best solution and cost
        best_solution = current_solution;
        best_cost = rastrigin(current_solution);
        current_cost = best_cost;

        % Initialize temperature, cooling rate, and maximum iterations
        T = 500;
        cool_rate = 0.95;
        max_iterations = 500;

        % Initialize array to store best cost per iteration
        value = zeros(1, max_iterations);

        % Perform simulated annealing iterations
        for i = 1:max_iterations
            % Generate a random neighbor within a small range
            neighbor = current_solution + rand(1,2)* 0.1 - 0.05;

            % Check if neighbor is within the search space
            if any(neighbor < -5.12) || any(neighbor > 5.12)
                continue;
            end

            % Calculate cost of the neighbor solution
            neighbor_cost = rastrigin(neighbor);

            % Calculate change in cost
            delta_cost = neighbor_cost - current_cost;

            % Accept the neighbor solution based on the Metropolis criterion
            if delta_cost < 0 || exp(-delta_cost/T) > rand()
                current_solution = neighbor;
                current_cost = neighbor_cost;

                % Update best solution if the current solution is better
                if current_cost < best_cost
                    best_solution = current_solution;
                    best_cost = current_cost;
                end

                % Cool down the temperature
                T = T * cool_rate;

                % Store the best cost for this iteration
                value(i) = best_cost;
            end
        end

        % Store the best cost and solution for this run
        F(k) = best_cost;
        X(k,:) = best_solution;
    end

    % Display statistics
    disp('Min: ')
    disp(min(F))
    disp('Mean: ')
    disp(mean(F))
    disp('Max: ')
    disp(max(F))
    disp('STD: ')
    disp(std(F))

    % Plot the best cost per iteration
    plot(value)
    xlabel('Iteration')
    ylabel('F(x1,x2)')
end

% Define the Rastrigin function for optimization
function cost = rastrigin(x)
    % Check if input is within the valid range
    if any(x < -5.12) || any(x > 5.12)
        error('Input x is outside the valid range [-5.12, 5.12]');
    end
    
    % Compute the Rastrigin function
    e=exp(1);
    cost = (20 + e-20*exp(-0.2*sqrt((1/3).*sum(x.^2)))-exp((1/3).*sum(cos(2*pi*x))));
end
