load testData-public.mat

a = sim(bestNet, trainSamples);
exportCSV(getClasses(a));