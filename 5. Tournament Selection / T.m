% Define population size
populationSize = 10;

% Generate random fitness values for the population
fitnessValues = randi([1, 100], 1, populationSize);

% Define tournament size and number of parents to select
tournamentSize = 2;
numParents = 3;

% Perform tournament selection
selectedParents = tournamentSelection(fitnessValues, tournamentSize, numParents);

% Display selected parents and their fitness values
disp('Selected Parents:');
disp(selectedParents);
disp('Corresponding Fitness Values:');
disp(fitnessValues(selectedParents));
