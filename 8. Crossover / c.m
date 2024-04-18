% Define parents
parent1 = [1, 0, 1, 0, 1, 0, 1, 0];
parent2 = [1, 1, 0, 0, 1, 1, 0, 0];

% Perform single point crossover
[offspring1_sp, offspring2_sp] = singlePointCrossover(parent1, parent2);

% Perform two point crossover
[offspring1_tp, offspring2_tp] = twoPointCrossover(parent1, parent2);

% Perform uniform crossover
[offspring1_u, offspring2_u] = uniformCrossover(parent1, parent2);

% Single Point Crossover Function
function [offspring1, offspring2] = singlePointCrossover(parent1, parent2)
    % Select a random crossover point
    crossoverPoint = randi([1, numel(parent1) - 1]);
    
    % Create offspring by combining parts of the parents before and after the crossover point
    offspring1 = [parent1(1:crossoverPoint), parent2(crossoverPoint + 1:end)];
    offspring2 = [parent2(1:crossoverPoint), parent1(crossoverPoint + 1:end)];
    
    % Display crossover point and resulting offspring
    disp(['Single Point Crossover: Crossover Point = ', num2str(crossoverPoint)]);
    disp(['Offspring 1: ', num2str(offspring1)]);
    disp(['Offspring 2: ', num2str(offspring2)]);
end

% Two Point Crossover Function
function [offspring1, offspring2] = twoPointCrossover(parent1, parent2)
    % Select two random crossover points
    crossoverPoints = sort(randperm(numel(parent1) - 1, 2));
    
    % Create offspring by combining parts of the parents between the two crossover points
    offspring1 = [parent1(1:crossoverPoints(1)), parent2(crossoverPoints(1) + 1:crossoverPoints(2)), parent1(crossoverPoints(2) + 1:end)];
    offspring2 = [parent2(1:crossoverPoints(1)), parent1(crossoverPoints(1) + 1:crossoverPoints(2)), parent2(crossoverPoints(2) + 1:end)];
    
    % Display crossover points and resulting offspring
    disp(['Two Point Crossover: Crossover Points = ', num2str(crossoverPoints)]);
    disp(['Offspring 1: ', num2str(offspring1)]);
    disp(['Offspring 2: ', num2str(offspring2)]);
end

% Uniform Crossover Function
function [offspring1, offspring2] = uniformCrossover(parent1, parent2)
    % Generate a binary mask with the same size as the parents
    mask = randi([0, 1], size(parent1));
    
    % Create offspring by selecting bits from either parent using the mask
    offspring1 = parent1 .* mask + parent2 .* (1 - mask);
    offspring2 = parent2 .* mask + parent1 .* (1 - mask);
    
    % Display the mask and resulting offspring
    disp(['Uniform Crossover: Mask = ', num2str(mask)]);
    disp(['Offspring 1: ', num2str(offspring1)]);
    disp(['Offspring 2: ', num2str(offspring2)]);
end
