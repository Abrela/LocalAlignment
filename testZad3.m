clear all;
clc;
close all;

%% Wczytanie sekwencji rêcznie

%fastaContent=inputFasta();

%% Wczytywanie sekwencji z pliku o formacie FASTA

A = 'sequence.fasta';
B = 'Rhino.txt';
C = 'Mastodon.txt';
D = 'Human.txt';
E = 'AsiaticElephant.txt';

%fastaContent1=fetchFile(B)
%fastaContent2=fetchFile(C)

%% Wczytywanie sekwencji z bazy danych NCBI

%%fastaContent=fetchFasta('AC073210.8')

%% Zapisa w formie tablicy struktur

%[S]=saveAsStruct( fastaContent )

%% Funkcja do odczytu pliku, parsowania i zapisu w formie struktury

 %S1='ACTGACCC';
 %S2='ACTGATTT';
 %S2='CTTAGA';
 %S1='GTAA';
 %S1 = 'ACG';
 %S2 = 'TCGG';
 %S1 = 'GTAA';
 %S2 = 'CTTAGA';
 S2 = 'AGT';
 S1 = 'AAC';

 %FastaSet1 = loadFasta('file','sequence.fasta');
 %FastaSet2 = loadFasta('file','sequence.fasta');
 
 FastaSet1 = loadFasta('file',B); 
 FastaSet2 = loadFasta('file',D);
 
 %FastaSet1 = loadFasta('manual','');
 %FastaSet2 = loadFasta('manual','');
 
 %% Wyznaczenie macierzy punktacji lokalnego algorytmu dopasowania
 
 subtitutionMatrix = 'SubtitutionMatrix.txt';
 gap = -1;
 
 %[ mSW, coordinateRowMax, coordinateColumnMax, maxValueOut, bias, vertical, horizontal, sOut ] = ...
 %matrixScore( S1, S2, subtitutionMatrix, gap );

 [ mSW, coordinateRowMax, coordinateColumnMax, maxValueOut, bias, vertical, horizontal, sOut ] = ...
 matrixScore( FastaSet1.sequence, FastaSet2.sequence, subtitutionMatrix, gap );
 
 %% Optymalna œcie¿ka dopasowania 
 for i = 1:size(coordinateRowMax) % tyle razy, ile jest maksymalnych wartoœci
     
 %[ pathOut, lengthAlignmentOut, identityOut, gapsOut, s1Out, s2Out, last ] = ...
 %matchPath(S1, S2, mSW, coordinateRowMax(i), coordinateColumnMax(i), bias, vertical, horizontal );

 [ pathOut, lengthAlignmentOut, identityOut, gapsOut, s1Out, s2Out, last ] = ...
 matchPath(FastaSet1.sequence, FastaSet2.sequence, mSW, coordinateRowMax(i), ...
 coordinateColumnMax(i), bias, vertical, horizontal );
  
 
 %Graficzne wyœwietlenie tablicy punktacji
 header1 = 'aaa';
 header2 = 'bbb';
  
 %graphicOutput(mSW, pathOut, header1, header2);
 
 graphicOutput(mSW, pathOut, FastaSet1.header, FastaSet2.header);
 
 %Zapis do pliku w dwóch formatach
 mode = 'distance';
 fileName = 'localAlignment.txt';
 fileFastaName = 'localAlignmentFasta.txt';
 
 %fileOutput( S1, S2, header1, header2, mode, gap, lengthAlignmentOut, maxValueOut, ...
 % identityOut, gapsOut, s1Out, s2Out, sOut, fileName, fileFastaName );

 fileOutput( FastaSet1.sequence, FastaSet2.sequence, FastaSet1.header, FastaSet2.header, mode, gap, ...
 lengthAlignmentOut, maxValueOut, identityOut, gapsOut, s1Out, s2Out, sOut, fileName, fileFastaName );
 end