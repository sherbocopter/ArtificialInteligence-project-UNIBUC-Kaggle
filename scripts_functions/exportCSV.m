function [] = exportCSV(labels)

Id = (1:size(labels, 1))';
Prediction = labels;

resultsTable = table(Id, Prediction);
writetable(resultsTable,'testSamplesResults.csv','WriteRowNames',true)

end