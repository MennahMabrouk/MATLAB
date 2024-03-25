% Accession number
accessionNumber = 'NM_001345678';

% Part a) Import the sequence from GenBank and store into a flat file
gbRecord = getgenbank(accessionNumber);
sequence = gbRecord.Sequence;

% Write sequence to a flat file
fastaFileName = 'sequence.fasta';
fastawrite(fastaFileName, accessionNumber, sequence);

% Part b) Extract the coding region and write the results in the previous file
codingRegion = getgenbank(accessionNumber, 'SequenceOnly', false); % Fetch full record

% Check if CDS information is available
if isfield(codingRegion, 'CDS')
    % If there are multiple CDS features, you might need to loop over them
    codingStart = codingRegion.CDS.indices(1,1);
    codingEnd = codingRegion.CDS.indices(1,2);

    % Extract coding sequence
    codingSequence = sequence(codingStart:codingEnd);

    % Write coding sequence to the same file
    fid = fopen(fastaFileName, 'a');
    fprintf(fid, '\n>Coding Sequence\n%s', codingSequence);
    fclose(fid);

    disp('Operations completed successfully.');
else
    disp('No coding sequence information available.');
end
