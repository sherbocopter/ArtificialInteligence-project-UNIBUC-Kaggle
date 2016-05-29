load trainData.mat;

% codare
X = trainSamples;
T = zeros(10, size(X, 2));
for i = 1:size(X, 2)
    T(trainLabels(i), i) = 1;
end

% indici pentru cross-validare
indices = [1 100 101 200;
            101 200 201 300;
            201 300 301 400;
            301 400 401 500;
            401 500 501 600;
            501 600 601 700;
            601 700 701 800;
            701 800 801 900;
            801 900 901 1000;
            901 1000 1 100];

accuracies = zeros(10, 1);
bestAccuracy = 0;
bestNet = 0;
confMatrices = zeros(10, 10, 10);

% cross-validare
for i = 1:10
    % reinitializare retea
    net = newff(minmax(X), [400 350 10], {'purelin', 'logsig', 'logsig'}, 'traingdx', 'learngdm', 'mse');
    net.trainParam.epochs = 10000;
    net.trainParam.goal = 0.00001;
    net.trainParam.max_fail = 12;
    
    % impartirea pentru early stop dupa indici de mai sus
    net.divideFcn = 'divideind';
    indici_testare = indices(i, 1):indices(i, 2);
    indici_validare = indices(i, 3):indices(i, 4);
    indici_antrenare = 1:1000;
    indici_antrenare([indici_testare indici_validare]) = [];
    net.divideParam.trainInd = indici_antrenare;
    net.divideParam.valInd = indici_validare;
    net.divideParam.testInd = indici_testare;
    
    [net, info] = train(net, X, T);
    
    % simularea pe multimea de test
    a = sim(net, X(:, indici_testare));
    
    validationClasses = getClasses(a); % decodare
    trainingClasses = trainLabels(indici_testare);
    
    localAccuracy = size(find(validationClasses == trainingClasses), 1) / size(indici_testare, 2);
    accuracies(i, 1) = localAccuracy;
    
    % pastrarea retelei cu cea mai mare acuratete pe multimea de test
    if localAccuracy > bestAccuracy
        bestAccuracy = localAccuracy;
        bestNet = net;
    end
    
    confMatrix = confusionmat(validationClasses, trainingClasses);
    confMatrices(:, :, i) = confMatrix;
end

meanAccuracy = mean(accuracies);