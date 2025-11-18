% Image Grayscale Conversion and Analysis Script
% This script reads an image, converts it to grayscale, extracts pixel intensity values with coordinates,
% calculates row-wise average intensities, and exports results for further analysis.

%% Image Reading and Preprocessing
% Read input image
img = imread('C:\Users\28368\Downloads\221.png'); % Replace with your image path

% Convert to grayscale if RGB image
if size(img, 3) == 3
    grayImg = rgb2gray(img);
else
    grayImg = img;
end

%% Grayscale Image Visualization
figure;
imshow(grayImg);
title('Grayscale Image');
saveas(gcf, 'gray_image.png'); % Save grayscale image as PNG file

%% Coordinate System Generation and Data Extraction
% Generate coordinate grid
[height, width] = size(grayImg);
[X, Y] = meshgrid(1:width, 1:height);

% Create coordinate-intensity data matrix
coordData = [X(:), Y(:), double(grayImg(:))];

%% Data Export with Headers
% Export coordinate-intensity data to CSV
header = {'X_Coordinate', 'Y_Coordinate', 'Intensity_Value'};
writecell(header, 'gray_values_with_coords.csv');
writematrix(coordData, 'gray_values_with_coords.csv', 'WriteMode', 'append');

%% Row-wise Intensity Analysis
% Calculate mean intensity for each row
rowAverages = mean(grayImg, 2); % Compute mean along columns (dimension 2)

% Create row average data matrix
rowData = [(1:height)', rowAverages];

% Export row averages to CSV
rowHeader = {'Row_Number', 'Mean_Intensity'};
writecell(rowHeader, 'row_averages.csv');
writematrix(rowData, 'row_averages.csv', 'WriteMode', 'append');

%% Row Average Visualization
figure;
plot(1:height, rowAverages, '-o', 'LineWidth', 1.5);
xlabel('Row Number');
ylabel('Mean Intensity Value');
title('Row-wise Average Intensity Profile');
ylim([0 255]); % Set y-axis range to 0-255
grid on;
saveas(gcf, 'row_averages_plot.png'); % Save intensity profile plot

%% Completion Notification
disp('Grayscale image saved as: gray_image.png');
disp('Coordinate-intensity data exported as: gray_values_with_coords.csv');
disp('Row average intensities exported as: row_averages.csv');
disp('Intensity profile plot saved as: row_averages_plot.png');
