function brainfuck(program)

global ATYPE AMAX AMIN

NCELLS = 30000;
ATYPE  = 'uint8';
AMAX   = intmax(ATYPE);
AMIN   = intmin(ATYPE);
N = length(program);

i = 1;                      % instruction pointer
p = 1;                      % data pointer
a = char(zeros(1,NCELLS));  % data array

% Paren matching routine
q = match_parens(program,N);

% Interpreter
while i < N+1
    
    switch program(i)
        case '>'                    % move pointer right
            p = p + 1;
        case '<'                    % move pointer left
            p = p - 1;
        case '+'                    % increment byte at pointer
            a(p) = inc(a(p));
        case '-'                    % decrement byte at pointer
            a(p) = dec(a(p));
        case '.'                    % output character at pointer location
            putchar(a(p));
        case ','                    % read one byte from input and store at pointer location
            a(p) = getchar();
        case '['                    % if a(p)=0, skip past matching bracket
            if a(p) == 0, i = q(i); end
        case ']'                    % if a(p)!=0, return to opening bracket
            if a(p) ~= 0, i = q(i) - 1; end
        case ';'                    % read one byte from keyboard as numeric value, and store at pointer location
            a(p) = getint();
        case ':'                    % write byte at pointer location as a numeric value
            putint(a(p));
        case '$'                    % debugging command - dumps a(1:10) to the console
            disp(uint8(a(1:10)))
    end
    
    i = i + 1;
    
end

function c = getchar()
inp = input('','s');
if isempty(inp)
    c = char(0);
elseif inp(1) == '\'
    switch inp(2)
        case 's'
            c = ' ';
        case 'n'
            c = char(10);
    end 
else   
    c = inp(1);
end

function putchar(c)
fprintf('%s',char(c));

function c = getint();
inp = input('','s');
if isempty(inp)
    c = 0;
else
    c = uint8(str2double(inp));
end

function putint(c)
fprintf('%4d',c);

function a = inc(a)
global AMIN AMAX
if a < AMAX
    a = a + 1;
else
    a = AMIN;
end

function a = dec(a)
global AMIN AMAX
if a > AMIN
    a = a - 1;
else
    a = AMAX;
end

function q = match_parens(program,N)
q = zeros(1,N);
d = [];
for j = 1:N
    if program(j) == '['
        d(end+1) = j;           %#ok<AGROW>
    elseif program(j) == ']'
        q(d(end)) = j;
        q(j)      = d(end);     
        d(end) = [];            %#ok<AGROW>
    end
end
    