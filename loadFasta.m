function [ FastaSetOut ] = loadFasta( method, source )
%LOADFASTA Funkcja g³ówna, która decyduje jak¹ metod¹ bêd¹ wczytywane
%sekwecje.
%   Argumentem wejœciowym jest metoda jak¹ wczytywany jest plik (method) 
%   oraz sekwencja (source). Funkcja zawiera subfunkcje. Argumentem 
%   wyjœciowym jest sparsowany oraz umieszczony w strukturze (struct)  
%   wczytany wczeœñiej plik(source). 


if method == "manual"
    fastaContent = inputFasta(); % subfunkcja
elseif method == "file"
    fastaContent = fetchFile(source); % subfunkcja
elseif method == "ncbi"
    fastaContent = fetchFasta(source); % subfunkcja
else
    fprintf('None of the entered inputs are valid');
end

FastaSet = saveAsStruct(fastaContent); % subfunkcja
FastaSetOut = FastaSet;

end