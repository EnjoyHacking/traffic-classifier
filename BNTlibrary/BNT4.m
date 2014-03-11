% Varijable
% 1 - Freq u jednom periodu

intra = ones(1);

inter = zeros(1);

bnet = mk_dbn(intra, inter, [1], 'discrete', [], 'observed', [1]);

bnet.CPD{1} = gaussian_CPD(bnet, 1);
bnet.CPD{2} = gaussian_CPD(bnet, 2);