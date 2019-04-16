function [Sout] = saveAsStruct( ftext )
%SAVEASSTRUCT Subfunkcja, która parsuje wczytany plik FASTA i zapisuje go 
%w strukturze (struct).
%   Argumentem wejœciowym jest wczytywany plik FASTA. Sparsowany plik
%   zapisany w strukturze (osobno nag³ówek i osobno sekwencja) jest
%   argumentem wyjœciowym subfunkcji.
 
file = strtrim(strread(ftext,'%s','whitespace','','delimiter','\n'));
field=file(1);
values=file(2:end);

% Zapis sparsowanego pliku w komórce (cell) 
C=cell(size(2,1));
C{1,1}=join(values, '');
C{2,1}=field;

% Zapis w strukturze (struct)
S=struct('header', C{2,1}, 'sequence', C{1,1});
Sout=S;

end