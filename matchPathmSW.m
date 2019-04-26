function [ pathOut, lengthAlignmentOut, identityOut, gapsOut, s1Out, s2Out, last ] = ...
    matchPathmSW(seq1, seq2, mSW, rowMax, columnMax, bias, vertical, horizontal )

    path = zeros(size(mSW));
    last = [rowMax, columnMax]; %zmienna o wspó³rzêdnych max punktacji
    gaps = 0;
    identity = 0;
    s1 = '';
    s2 = '';
    %path(last(1),last(2)) = 1;
        
        while (mSW(last(1),last(2)) > 0) % last(1) - ilosc wierszy, last(2) - ilosc kolumn
       
            path(last(1),last(2)) = 1; 
            diagonal = bias(last(1),last(2));
            left = vertical(last(1),last(2));
            up = horizontal(last(1),last(2));
            
            if(diagonal == 1)
                max1 = mSW(last(1)-1,last(2)-1);
            else
                max1 = NaN;
            end
            if(left == 1)
                max2 = mSW(last(1)-1,last(2));
            else
                max2 = NaN;
            end
            if(up == 1)
                max3 = mSW(last(1),last(2)-1);
            else
                max3 = NaN; 
            end
                
            MAX = max([max1, max2, max3]);
            
            if(MAX == max1 )
                last = [last(1)-1, last(2)-1];
                s1 = strcat(s1, seq1(last(1)));
                s2 = strcat(s2, seq2(last(2)));
                identity = identity+1;  
            end
            if(MAX == max2)
                last = [last(1)-1, last(2)]; 
                gaps = gaps+1;
                s1 = strcat(s1, seq1(last(1)));
                s2 = strcat(s2, '-');
            end
            if(MAX == max3)
                last = [last(1), last(2)-1];
                gaps = gaps+1;
                s1 = strcat(s1, '-');
                s2 = strcat(s2, seq2(last(2)));
            end

            
        end
        
        pathOut = path;
        identityOut = identity;
        gapsOut = gaps;
        s1Out = fliplr(s1);
        s2Out = fliplr(s2);

        % d³ugoœæ lokalnego dopasowania
        [r, c] = size(path);
        lengthAlignment = 0;
        for m = 1:r
            for n = 1:c
                if (path(m,n) == 1)
                    lengthAlignment = lengthAlignment+1;
                end
            end
        end
        lengthAlignmentOut = lengthAlignment; 
end

