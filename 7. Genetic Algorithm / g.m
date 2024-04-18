% Define the permutation and genetic distances matrix
permutation = [2, 4, 1, 5, 3];
genetic_distances = [
    0, 10, 15, 20, 25;
    10, 0, 35, 25, 30;
    15, 35, 0, 30, 20;
    20, 25, 30, 0, 18;
    25, 30, 20, 18, 0
];

% Calculate the total distance of the route
total_distance = calculate_total_distance(permutation, genetic_distances);

% Display the total distance
disp(['Total genetic distance of the route: ', num2str(total_distance)]);

% Function to calculate the total distance of a route
function total_distance = calculate_total_distance(permutation, genetic_distances)
    num_genes = length(permutation);
    total_distance = 0;
    
    % Calculate the total distance by summing the distances between consecutive genes
    for i = 1:num_genes - 1
        current_gene = permutation(i);
        next_gene = permutation(i + 1);
        total_distance = total_distance + genetic_distances(current_gene, next_gene);
    end
    
    % Add the distance from the last gene back to the starting gene to complete the route
    total_distance = total_distance + genetic_distances(permutation(end), permutation(1));
end
