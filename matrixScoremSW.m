function [ mSWout, coordinateRowMax, coordinateColumnMax, maxValueOut, bias, vertical, horizontal, sOut ] = ...
    matrixScoremSW( seq1, seq2, subtitutionMatrix, gap )

N1 = length(seq1);
N2 = length(seq2);

mSW = zeros( N1+1, N2+1 ); %prealokacja
[rows, columns]=size(mSW);

s=readtable(subtitutionMatrix, 'ReadRowNames', true); %wczytanie macierzy substytucji

mSW(1,1) = 0; % elemnt (1,1) macierzy zawsze 0
for i = 2:(N1+1) 
    mSW(i,1) = 0; % wype³nienie pierwszej kolumny zerami
end
for j = 2:(N2+1)  
    mSW(1,j) = 0; % wype³nienie pierwszego wiersza zerami
end

%mo¿liwe przejœcia we wszystkich kierunkach
bias = zeros(size(mSW,1), size(mSW,2));
vertical = zeros(size(mSW,1), size(mSW,2));
vertical(2:size(vertical,1),1) = ones(size(vertical,1)-1,1); % wype³nienie jedynkami pierwszej kolumny vertical
horizontal = zeros(size(mSW,1), size(mSW,2));
horizontal(1,2:size(horizontal,2)) = ones(1,size(horizontal,2)-1); % wype³nienie jedynkami pierwszego wiersza horizontal 

currentRow = mSW(1,:);

for i = 2:rows %kolejne nr wierszy
    
    lastRow = currentRow; %zapisany poprzedni wiersz
    currentRow = mSW(i,:); %zapisany aktualny wiersz
    best=currentRow(1); %pierwszy element z atualnego wiersza nadpisany jako najlepsza opcja 
    
    for j = 2:columns %kolejne nr kolumn
        
    up = lastRow(j) + gap;
    
    if (up<0)
        up = 0;
    end
    
    left = best + gap;
    
    if (left<0)
        left = 0;
    end
    
    if seq1(i-1) == seq2(j-1) 
        diagonal = lastRow(j-1) + s{seq1(i-1),seq2(j-1)}; 
    else
        diagonal = lastRow(j-1) + s{seq1(i-1),seq2(j-1)};
    end
    
    if (diagonal<0)
        diagonal = 0;
    end
        
              
     MAX = max([up, left, diagonal]);
             
    if(MAX == diagonal)
        bias(i, j) = 1;
    end
    if(MAX == up)
        vertical(i, j) = 1;
    end
    if(MAX == left)
        horizontal(i, j) = 1;
    end
    
    if up > left
        best = up;     
    else 
        best = left;     
    end
    
    if diagonal >= best
        best = diagonal;
    end
    currentRow(j) = best; % najlepszy wynik punktacji zapisywany zapisywany w macierzy
        
    end %end j
    
    mSW(i,:) = currentRow; % zapisz wiersz z punktacja w macierzy
         
end %end i
mSWout = mSW;
sOut = s;

maxValue = max(max(mSW));
[coordinateRowMax,coordinateColumnMax] = find(mSW == maxValue); %wspó³rzêdne punktów najwy¿szej punktacji
maxValueOut = maxValue; %maksymalna punktacja wyœwietlana w zapisanym pliku
end

