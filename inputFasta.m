function fastaContent = inputFasta()
%INPUTFASTA Rêczne wczytanie sekwencji.

fastaContent = ['>', input('indentifier:', 's'), char(10),...
    input('sequence:','s')]; % char(10) - spacja

end