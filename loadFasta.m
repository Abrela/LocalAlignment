function [ FastaSetOut ] = loadFasta( method, source )
%LOADFASTA Funkcja g��wna, kt�ra decyduje jak� metod� b�d� wczytywane
%sekwecje.
%   Argumentem wej�ciowym jest metoda jak� wczytywany jest plik (method) 
%   oraz sekwencja (source). Funkcja zawiera subfunkcje. Argumentem 
%   wyj�ciowym jest sparsowany oraz umieszczony w strukturze (struct)  
%   wczytany wcze��iej plik(source). 


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