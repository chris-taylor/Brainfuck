function runbf(filename)

fid = fopen(filename);
lns = textscan(fid, '%s', 'Delimiter', '\n');
lns = lns{1};
lns = horzcat(lns{:});

brainfuck(lns);