function selected_indices = rouletteWheelSelection(fitness_values, num_parents)
    % Calculate selection probabilities based on fitness values
    selection_probabilities = fitness_values / sum(fitness_values);

    % Initialize selected_indices
    selected_indices = zeros(num_parents, 1);

    % Perform roulette wheel selection for each parent
    for i = 1:num_parents
        % Generate a random number between 0 and 1
        random_number = rand();
        
        % Initialize cumulative probability and selected index
        cumulative_probability = 0;
        selected_index = 1;
        
        % Calculate cumulative probability until it exceeds the random number
        while cumulative_probability < random_number && selected_index < numel(fitness_values)
            cumulative_probability = cumulative_probability + selection_probabilities(selected_index);
            selected_index = selected_index + 1;
        end

        % Add the selected index to selected_indices
        selected_indices(i) = selected_index;
        disp(['Selected index: ', num2str(selected_index), ', Cumulative probability: ', num2str(cumulative_probability)])
    end
end
