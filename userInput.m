clear all;
clc;
close all;

prompt = 'Wybierz rodzaj wczytywania sekwencji (manual, file lub ncbi): ';
subtitutionMatrix = 'SubtitutionMatrix.txt';
mode = 'distance';

method = input(prompt, 's');

if isequal(method,'manual')
    prompt1 = 'Wpisz pierwsz¹ sekwencjê: ';
    prompt2 = 'Wpisz identyfikator pierwszej sekwencji: ';
    prompt3 = 'Wpisz drug¹ sekwencjê: ';
    prompt4 = 'Wpisz identyfikator drugiej sekwencji: ';
    prompt5 = 'Okreœl punktacjê za gap: ';
    prompt6 = 'Podaj nazwê do zapisu pliku lokalnego dopasowania (*.txt): ';
    prompt7 = 'Podaj nazwê do zapisu pliku FASTA (*.txt): ';
    
    S1 = input(prompt1, 's');
    header1 = input(prompt2, 's');
    S2 = input(prompt3, 's');
    header2 = input(prompt4, 's');
    gap = input(prompt5);
    fileName = input(prompt6, 's');
    fileFastaName = input(prompt7, 's');
    
    [ mSW, coordinateRowMax, coordinateColumnMax, maxValueOut, bias, vertical, horizontal, sOut ] = ...
    matrixScoremSW( S1, S2, subtitutionMatrix, gap );

         for i = 1:size(coordinateRowMax) % tyle razy, ile jest maksymalnych wartoœci

         [ pathOut, lengthAlignmentOut, identityOut, gapsOut, s1Out, s2Out, last ] = ...
         matchPathmSW(S1, S2, mSW, coordinateRowMax(i), coordinateColumnMax(i), bias, vertical, horizontal );

         graphicOutput(mSW, pathOut, header1, header2);

         fileOutput( S1, S2, header1, header2, mode, gap, lengthAlignmentOut, maxValueOut, ...
          identityOut, gapsOut, s1Out, s2Out, sOut, fileName, fileFastaName );
         end
else
    
    prompt1 = 'Podaj nazwê pierwszego pliku lub identyfikatora: ';
    prompt5 = 'Podaj nazwê drugiego pliku lub identyfikatora: ';
    prompt2 = 'Okreœl punktacjê za gap: ';
    prompt3 = 'Podaj nazwê do zapisu pliku lokalnego dopasowania (*.txt): ';
    prompt4 = 'Podaj nazwê do zapisu pliku FASTA (*.txt): ';
    
    source1 = input(prompt1, 's');
    source2 = input(prompt5, 's');
    gap = input(prompt2);
    fileName = input(prompt3, 's');
    fileFastaName = input(prompt4, 's');
    
    FastaSet1 = loadFasta(method, source1);
    FastaSet2 = loadFasta(method, source2);
    
    
    [ mSW, coordinateRowMax, coordinateColumnMax, maxValueOut, bias, vertical, horizontal, sOut ] = ...
    matrixScoremSW( FastaSet1.sequence, FastaSet2.sequence, subtitutionMatrix, gap );

         for i = 1:size(coordinateRowMax) % tyle razy, ile jest maksymalnych wartoœci

         [ pathOut, lengthAlignmentOut, identityOut, gapsOut, s1Out, s2Out, last ] = ...
         matchPathmSW(FastaSet1.sequence, FastaSet2.sequence, mSW, coordinateRowMax(i), ...
         coordinateColumnMax(i), bias, vertical, horizontal );

         graphicOutput(mSW, pathOut, FastaSet1.header, FastaSet2.header);

         fileOutput( FastaSet1.sequence, FastaSet2.sequence, FastaSet1.header, FastaSet2.header, mode, gap, ...
         lengthAlignmentOut, maxValueOut, identityOut, gapsOut, s1Out, s2Out, sOut, fileName, fileFastaName );
         end
end