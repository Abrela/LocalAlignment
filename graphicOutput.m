function [] = graphicOutput(mSW, path, header1, header2)

[row, column] = size(path);
graphic = zeros(row, column);

    for i = 1:row
        for j = 1:column
            if(path(i,j)==1) 
                graphic(i,j) = mSW(i,j);
            end
        end
    end

%dlmwrite('localAlignment.txt', graphic, '_');
%type('localAlignment.txt');


figure;
colormap('jet');
imagesc(graphic);
colorbar;
axis xy;
title('Dopasowanie lokalne par sekwencji');
xlabel (header1); 
ylabel (header2);
saveas(gcf,'LocalFile.jpg');

end

