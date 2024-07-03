% Example testing:
inputFilename = 'example.csv';  % Replace with input CSV file name
comments = {'Date', 'Time', 'Latitude', 'Longitude', 'Speed', 'CELL_ID', 'BAND', 'RSSI', 'RSRP', 'SINR', 'RSRQ'};
outputFilename = 'output-1.csv';

processTabSeparatedCSV(inputFilename, comments, outputFilename);
