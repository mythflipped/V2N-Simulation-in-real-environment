% Example testing:
inputFilename = 'test.csv';  % Replace with your input CSV file name
comments = {'Date', 'Time', 'Latitude', 'Longitude', 'Speed', 'CELL_ID', 'BAND', 'RSSI', 'RSRP', 'SINR', 'RSRQ'};
outputFilename = 'output_Fin.csv';
outputLatLongFilename = 'output_latlong_Fin.csv';

processAndExtractLatLong(inputFilename, comments, outputFilename, outputLatLongFilename);