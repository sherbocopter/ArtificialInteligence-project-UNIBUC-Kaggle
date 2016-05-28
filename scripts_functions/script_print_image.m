load trainData.mat;

class1 = find(trainLabels == 1);
class2 = find(trainLabels == 2);
class3 = find(trainLabels == 3);
class4 = find(trainLabels == 4);
class5 = find(trainLabels == 5);
class6 = find(trainLabels == 6);
class7 = find(trainLabels == 7);
class8 = find(trainLabels == 8);
class9 = find(trainLabels == 9);
class10 = find(trainLabels == 10);

samples = [trainSamples(:, class1(1)) trainSamples(:, class1(2))...
    trainSamples(:, class2(1)) trainSamples(:, class2(2))...
    trainSamples(:, class3(2)) trainSamples(:, class3(3))];

figure;

for k = 1:6
    sample = samples(:, k);
    subplot(3, 2, k);
    hold on;
    axis([0, 0.3, 0, 0.3]);
    for i = 1:28
        for j = 1:28
            color = 1 - sample((i - 1) * 28 + j);
            plot(i / 100, j / 100, 's',...
                    'MarkerSize',10,...
                    'MarkerEdgeColor','w',...
                    'MarkerFaceColor',[1 1 1] * color);
        end
    end
end

hold off;


