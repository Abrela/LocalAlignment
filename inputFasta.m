function fastaContent = inputFasta()
%INPUTFASTA R�czne wczytanie sekwencji.

fastaContent = ['>', input('indentifier:', 's'), char(10),...
    input('sequence:','s')]; % char(10) - spacja

end