function percentage = classPercentage(classes, maxClass)
    percentage = zeros(1, maxClass);
    for i = 1:maxClass
        percentage(i) = size(find(classes == i), 1);
    end
    
    percentage = percentage ./ (size(classes, 1) * size(classes, 2));
end