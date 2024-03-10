%The climb function initializes the range for the X dimension and generates two initial random solution points (initial_solution_1 and initial_solution_2) within this range. It then conducts hill climbing optimization with a fixed step size and maximum iterations, utilizing these two points to find the best solutions. Finally, it displays the best solutions and their corresponding values before plotting the optimization process.

function climb()
    % Define the range for X dimension
    range_x = [-2, 2];
    
    % Generate initial solution points within specified range for X
    initial_solution_1 = rand() * (range_x(2) - range_x(1)) + range_x(1);
    initial_solution_2 = rand() * (range_x(2) - range_x(1)) + range_x(1);
    
    step_size = 0.1;
    max_iteration = 100;
    
    % Start hill climbing
    [final_solution_1, final_solution_2] = hill_climbing_minimize(@rastrigin, initial_solution_1, initial_solution_2, step_size, max_iteration);
    
    % Display best solutions and values
    disp('Best solution 1:');
    disp(final_solution_1);
    
    disp('Best value 1:');
    disp(rastrigin(final_solution_1));
    
    disp('Best solution 2:');
    disp(final_solution_2);
    
    disp('Best value 2:');
    disp(rastrigin(final_solution_2));
    
    % Plot final result
    plot_environment(final_solution_1, final_solution_2);
end

% The function hill_climbing_minimize iteratively updates two solutions (current_solution_1 and current_solution_2) by adding random noise to them. It evaluates the cost of these solutions using the provided cost function and updates them if a new solution improves the cost. After a specified number of iterations, it returns the final optimized solutions.

function [final_solution_1, final_solution_2] = hill_climbing_minimize(cost_function, initial_solution_1, initial_solution_2, step_size, max_iteration)
    current_solution_1 = initial_solution_1;
    current_solution_2 = initial_solution_2;
    
    for iter = 1:max_iteration
        % Generate new solutions
        new_solution_1 = current_solution_1 + step_size * randn();
        new_solution_2 = current_solution_2 + step_size * randn();
        
        % Evaluate new solutions
        new_value_1 = cost_function(new_solution_1);
        new_value_2 = cost_function(new_solution_2);
        
        % Update solutions if new solution is better
        if new_value_1 < cost_function(current_solution_1)
            current_solution_1 = new_solution_1;
        end
        if new_value_2 < cost_function(current_solution_2)
            current_solution_2 = new_solution_2;
        end
    end
    
    % Return the final solutions
    final_solution_1 = current_solution_1;
    final_solution_2 = current_solution_2;
end

% The plot_environment function visualizes the optimization process of the Rastrigin function by plotting it along with two specified points (point1 and point2). It generates 100 equally spaced values for the x-axis, evaluates the Rastrigin function for these values, and plots it. Additionally, it plots point1 and point2 as red and blue circles, respectively, on the function curve. Finally, it labels the axes, adds a title to the plot, and includes a legend indicating the Rastrigin function, Point 1, and Point 2.

function plot_environment(point1, point2)
    x = linspace(-2, 2, 100);
    y = rastrigin(x);
    
    figure;
    plot(x, y, 'k');
    hold on;
    plot(point1, rastrigin(point1), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10);
    plot(point2, rastrigin(point2), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10);
    hold off;
    xlabel('x');
    ylabel('f(x)');
    title('Optimization Process');
    legend('Rastrigin Function', 'Point 1', 'Point 2');
end

% The rastrigin function calculates the value of the Rastrigin function for a given input x. It involves a standard mathematical expression that incorporates squaring x, applying cosine, and adding constants. This function encapsulates the Rastrigin formula, providing a convenient way to evaluate it for optimization tasks.

function value = rastrigin(x)
    % Rastrigin function
    A = 10;
    value = A + x.^2 - A * cos(2 * pi * x);
end
