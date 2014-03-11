% Otvaranje datoteke
load Kam3.csv;

x = WinSizeInterval = 1:10;
y = EpsilonInterval = 20:5:90;

probMatrix = zeros(length(WinSizeInterval), length(EpsilonInterval));

n = 0;
for i = 1:length(WinSizeInterval)
    for j = 1:length(EpsilonInterval)
        probMatrix(i, j) = probParam(Kam3, WinSizeInterval(i), EpsilonInterval(j), 'u');
        n = n + 1
    end;
end;

size(probMatrix)

z = probMatrix;

mesh(WinSizeInterval, EpsilonInterval, probMatrix');
xlabel('Velicina prozora');
ylabel('Granica epsilon');
zlabel('P(guzva)');