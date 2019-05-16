function [] = fileOutput( s1, s2, header1, header2, mode, gap, length, ...
    maxValue, identityPoints, gapsPoints, seq1, seq2, s, fileName, fileFastaName )

identity = identityPoints/length*100;
gaps = gapsPoints/length*100; 
array = table2array(s); 

m = size(seq1);
line = '';
for i = 1:m(2)
    if seq1(i)==seq2(i)
        line = strcat(line, '|');
    else
        line = strcat(line, " ");
    end
end

%A= '*.txt';
%if(exist(fileName, 'file'))
%delete(A);   
%end

fileID = fopen(fileName,'a+');
fprintf(fileID, ...
    '# 1: %s \n# 2: %s \n# Mode: %s \n# Subtitution matrix: \n %5d %5d %5d %5d\n %5d %5d %5d %5d\n %5d %5d %5d %5d\n %5d %5d %5d %5d\n# Gap: %d \n# Score: %d \n# Length: %d \n# Identity: %d/%d (%3.0f%%) \n# Gaps: %d/%d (%3.0f%%) \n%s \n%s \n%s \n \n' , ...
    s1, s2, mode, array, gap, maxValue, length, identityPoints, ...
    length, identity, gapsPoints, length, gaps, seq1, line, seq2 );
fclose(fileID); 
%SaveAs(fileID, fileName);

fileID1 = fopen(fileFastaName,'a+');
fprintf(fileID1, '>%s \n%s \n\n>%s \n%s \n \n', header1, seq1, header2, seq2);
fclose(fileID1);
%SaveAs(fileID1, fileFastaName);

end

