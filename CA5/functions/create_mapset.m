%%Part1 Mapset function
function output = create_mapset()

    Nch = 32;
    output = cell(2,Nch);
    Alphabet = 'abcdefghijklmnopqrstuvwxyz .,!;"';
    for i = 1:Nch
        output{1,i} = Alphabet(i);
        output{2,i} = dec2bin(i-1,5);
    end
    
end