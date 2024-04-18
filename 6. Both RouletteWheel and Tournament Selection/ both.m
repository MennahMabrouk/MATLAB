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
