function processTabSeparatedCSV(inputFilename, comments, outputFilename)
    % Read the input CSV file
    fid = fopen(inputFilename, 'r');
    if fid == -1
        error('Cannot open input file: %s', inputFilename);
    end
    
    % Initialize a cell array to hold the processed data
    processedData = {};
    
    % Skip the first line
    fgetl(fid);
    
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
        processedData{lineIndex, 1} = splitString;
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
        outputData(i + 1, :) = processedData{i};
    end
    
    % Write the output data to a CSV file
    T = cell2table(outputData);
    writetable(T, outputFilename);
    
    % Display the result
    disp('Data has been written to the CSV file:');
    disp(T);
end



