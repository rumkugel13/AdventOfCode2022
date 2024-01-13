module day21;

import std.stdio, util, std.string, std.conv;

void day21()
{
    writeln("aoc22 day 21");
    auto lines = util.readLines("input/21.txt");

    string[string] monkeys;
    foreach (line; lines)
    {
        monkeys[line[0 .. 4]] = line[6 .. $];
    }

    writeln("part 1: ", part1(monkeys));
    writeln("part 2: ", 0);
}

long part1(string[string] monkeys)
{
    string[] queue;
    foreach (monkey, _; monkeys)
    {
        queue ~= monkey;
    }

    long[string] shout;

    while (queue.length > 0)
    {
        string current = queue[0];
        queue = queue[1 .. $];

        string monkeyVal = monkeys[current];

        if (monkeyVal[0] >= '0' && monkeyVal[0] <= '9')
        {
            long val = monkeyVal.to!long;
            shout[current] = val;
        }
        else
        {
            string a = monkeyVal[0 .. 4];
            char op = monkeyVal[5];
            string b = monkeyVal[7 .. $];

            if (a in shout && b in shout)
            {
                long result = 0;
                long valA = shout[a], valB = shout[b];
                switch (op)
                {
                case '*':
                    result = valA * valB;
                    break;
                case '+':
                    result = valA + valB;
                    break;
                case '-':
                    result = valA - valB;
                    break;
                case '/':
                    result = valA / valB;
                    break;
                default:
                    break;
                }
                shout[current] = result;
            }
            else
            {
                queue ~= current;
            }
        }
    }

    return shout["root"];
}
