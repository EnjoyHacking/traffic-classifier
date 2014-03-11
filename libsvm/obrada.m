%%%%% Obrada

load allObrSVM.txt;

N = size(allObrSVM, 1);
labels = zeros(N, 1);
data = allObrSVM(:, 1:5);

for i = 1:N
    if (allObrSVM(i, 6) > 150 && allObrSVM(i, 7) < 48)
        labels(i) = 1;
%     elseif (allObrSVM(i, 6) < 80 && allObrSVM(i, 7) > 52)
%         labels(i) = 1;
    else
        labels(i) = -1;
    end
    i
end

save y.txt labels -ascii;
save X.txt data   -ascii;