% Define population size
populationSize = 10;

% Generate random fitness values for the population
fitnessValues = randi([1, 100], 1, populationSize);

% Calculate total fitness of the population
totalFitness = sum(fitnessValues);

% Calculate selection probabilities based on fitness values
selectionProbabilities = fitnessValues / totalFitness;

% Perform roulette wheel selection
numParentsFromRoulette = 3;
selectedParentsRoulette = selectParentsRoulette(selectionProbabilities, numParentsFromRoulette);

% Perform tournament selection
tournamentSize = 2;
numParentsFromTournament = 2;
selectedParentsTournament = selectParentsTournament(fitnessValues, tournamentSize, numParentsFromTournament);

% Combine selected parents from both methods
selectedParents = [selectedParentsRoulette, selectedParentsTournament];

% Display selected parents
disp('Selected Parents:');
disp(selectedParents);

% Function for roulette wheel selection
function selectedParents = selectParentsRoulette(selectionProbabilities, numParents)
    populationSize = numel(selectionProbabilities);
    selectedParents = zeros(1, numParents);
    
    for i = 1:numParents
        r = rand();
        cumulativeProb = 0;
        for j = 1:populationSize
            cumulativeProb = cumulativeProb + selectionProbabilities(j);
            if r <= cumulativeProb
                selectedParents(i) = j;
                break;
            end
        end
    end
end

% Function for tournament selection
function selectedParents = selectParentsTournament(fitnessValues, tournamentSize, numParents)
    populationSize = numel(fitnessValues);
    selectedParents = zeros(1, numParents);
    
    for i = 1:numParents
        tournamentParticipants = randperm(populationSize, tournamentSize);
        tournamentFitness = fitnessValues(tournamentParticipants);
        [~, winnerIndex] = max(tournamentFitness);
        selectedParents(i) = tournamentParticipants(winnerIndex);
    end
end

% Now, integrate the following code:

% Define Rastrigin function
A = 10;
rastrigin = @(x) A + sum(x.^2 - A * cos(2 * pi * x));

% Evaluate fitness of selected parents using Rastrigin function
fitness_selectedParents = zeros(1, length(selectedParents));
for i = 1:length(selectedParents)
    individual = selectedParents(i);
    % Convert individual to binary representation, assuming each gene is a bit
    binary_individual = de2bi(individual);
    % Pad with zeros to match the length of parent1 and parent2
    padded_individual = [zeros(1, 8 - length(binary_individual)), binary_individual];
    % Convert to double
    double_individual = double(padded_individual);
    % Evaluate fitness
    fitness_selectedParents(i) = rastrigin(double_individual);
end

% Display fitness of selected parents
disp('Fitness of Selected Parents:');
disp(fitness_selectedParents);

% Define parents from the selected parents in fitness
parent1 = selectedParents(1, :);
parent2 = selectedParents(2, :);

% Perform single point crossover
[offspring1_sp, offspring2_sp] = singlePointCrossover(parent1, parent2);

% Perform two point crossover
[offspring1_tp, offspring2_tp] = twoPointCrossover(parent1, parent2);

% Perform uniform crossover
[offspring1_u, offspring2_u] = uniformCrossover(parent1, parent2);

% Perform mutation on offspring from single point crossover
mutationRate = 0.1;
mutated_offspring1_sp = bitFlipMutation(offspring1_sp, mutationRate);
mutated_offspring2_sp = bitFlipMutation(offspring2_sp, mutationRate);

% Perform mutation on offspring from two point crossover
mutated_offspring1_tp = bitFlipMutation(offspring1_tp, mutationRate);
mutated_offspring2_tp = bitFlipMutation(offspring2_tp, mutationRate);

% Perform mutation on offspring from uniform crossover
mutated_offspring1_u = bitFlipMutation(offspring1_u, mutationRate);
mutated_offspring2_u = bitFlipMutation(offspring2_u, mutationRate);

% Display mutated offspring from single point crossover
disp('Mutated Offspring from Single Point Crossover:');
disp(mutated_offspring1_sp);
disp(mutated_offspring2_sp);

% Display mutated offspring from two point crossover
disp('Mutated Offspring from Two Point Crossover:');
disp(mutated_offspring1_tp);
disp(mutated_offspring2_tp);

% Display mutated offspring from uniform crossover
disp('Mutated Offspring from Uniform Crossover:');
disp(mutated_offspring1_u);
disp(mutated_offspring2_u);

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

% Bit Flip Mutation Function
function mutatedOffspring = bitFlipMutation(offspring, mutationRate)
    % Perform bit flip mutation on each bit of the offspring with a certain mutation rate
    mutatedOffspring = offspring;
    for i = 1:numel(offspring)
        if rand() < mutationRate
            mutatedOffspring(i) = ~mutatedOffspring(i);
        end
    end
end
