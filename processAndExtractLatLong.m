function processAndExtractLatLong(inputFilename, comments, outputFilename, outputLatLongFilename)
    % Read the input CSV file
    fid = fopen(inputFilename, 'r');
    if fid == -1
        error('Cannot open input file: %s', inputFilename);
    end
    
    % Skip the first line (headers)
    fgetl(fid);
    
    % Initialize a cell array to hold the processed data
    processedData = {};
    
    % Read and process each line
    lineIndex = 1;
    while ~feof(fid)
        % Read the current line
        line = fgetl(fid);
        
        % Split the line based on tabs
        splitString = strsplit(line, '\t');
        
        % Remove quotation marks from all elements if present
        splitString = cellfun(@(x) strip(x, 'both', '"'), splitString, 'UniformOutput', false);
        
        % Adjust the length of splitString to match the number of comments
        if length(splitString) < length(comments)
            splitString = [splitString, repmat({''}, 1, length(comments) - length(splitString))];
        elseif length(splitString) > length(comments)
            splitString = splitString(1:length(comments));
        end
        
        % Store the split string in the cell array
        processedData{lineIndex, 1} = splitString;  % Correcting the indexing issue
        lineIndex = lineIndex + 1;
    end
    
    fclose(fid);
    
    % Convert the processed data to a cell array format for writing to CSV
    numColumns = length(comments);
    numRows = size(processedData, 1);
    outputData = cell(numRows + 1, numColumns);
    
    % Add comments as the first row
    outputData(1, :) = comments;
    
    % Add the data rows
    for i = 1:numRows
        outputData(i + 1, :) = processedData{i, 1};  % Correcting the indexing issue
    end
    
    % Write the full output data to a CSV file without the default table headers
    T = cell2table(outputData);
    writetable(T, outputFilename, 'WriteVariableNames', false);
    
    % Extract Latitude and Longitude columns
    latIndex = find(strcmp(comments, 'Latitude'));
    longIndex = find(strcmp(comments, 'Longitude'));
    
    % Initialize an array for Latitude and Longitude data
    latLongData = cell(numRows, 2);
    latLongData(1, :) = {'Latitude', 'Longitude'};  % Add header manually
    
    for i = 1:numRows
        latLongData{i + 1, 1} = outputData{i + 1, latIndex};
        latLongData{i + 1, 2} = outputData{i + 1, longIndex};
    end
    
    % Write the Latitude and Longitude data to a new CSV file
    T_latLong = cell2table(latLongData);
    writetable(T_latLong, outputLatLongFilename, 'WriteVariableNames', false);
    
    % Display the result
    disp('Full data has been written to the CSV file:');
    disp(T);
    disp('Latitude and Longitude data has been written to the CSV file:');
    disp(T_latLong);
end

