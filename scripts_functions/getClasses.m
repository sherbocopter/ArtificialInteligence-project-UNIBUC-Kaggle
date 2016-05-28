function T = getClasses(a)

T = zeros(size(a, 2), 1);

for i = 1:size(a, 2)
    testRes = a(:, i);
    cls = find(testRes == max(testRes));
    T(i) = cls(1);
end

end