function brainfuck(program)

NCELLS = 30000;
DEBUG  = false;
N = length(program) + 1;

iptr = 1;
dptr = 1;
data = char(zeros(1,NCELLS));

while iptr < N
   
    switch program(iptr)
        case '>'
            dptr = dptr + 1;
        case '<'
            dptr = dptr - 1;
        case '+'
            data(dptr) = data(dptr) + 1;
        case '-'
            data(dptr) = data(dptr) - 1;
        case '.'
            fprintf('%s',data(dptr));
        case ','
            data(dptr) = getchar();
        case '['
            if data(dptr) == 0
                depth = 1;
                iptr  = iptr + 1;
                while depth > 0
                    if program(iptr) == '['
                        depth = depth + 1;
                    elseif program(iptr) == ']'
                        depth = depth - 1;
                    end
                    iptr = iptr + 1;
                end
            end
        case ']'
            if data(dptr) ~= 0
                depth = 1;
                iptr  = iptr - 1;
                while depth > 0
                    if program(iptr) == ']'
                        depth = depth + 1;
                    elseif program(iptr) == '['
                        depth = depth - 1;
                    end
                    iptr = iptr - 1;
                end
            end
    end
    
    if DEBUG
        fprintf('iptr = %d\n', iptr);
        fprintf('dptr = %d\n', dptr);
        fprintf('data(%d) = %d\n', dptr, int32(data(dptr)))
    end
        
    iptr = iptr + 1;
    
end

function c = getchar()
inp = [];
while isempty(inp)
    inp = input('','s');
end
c = inp(1);