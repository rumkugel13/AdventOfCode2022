module day03;

import std.algorithm, std.array, std.stdio;
import util;

void day03()
{
    writeln("aoc22 day 03");

    auto input = readLines("input/03.txt");
    int sum = 0;

    foreach (line; input)
    {
        foreach (character; line[0 .. ($ / 2)]) // $ == line.length
        {
            if (canFind(line[line.length / 2 .. line.length], character))
            {
                sum += getPriority(character);
                break;
            }
        }
    }

    writeln("part 1: ", sum);

    sum = 0;

    for (int i = 0; i < input.length; i += 3)
    {
        auto parts = input[i .. i + 3];
        foreach (part; parts[0])
        {
            if (canFind(parts[1], part) && canFind(parts[2], part))
            {
                sum += getPriority(part);
                break;
            }
        }
    }

    writeln("part 2: ", sum);
}

int getPriority(char c)
{
    if (c >= 'a' && c <= 'z') return c - 'a' + 1;
    if (c >= 'A' && c <= 'Z') return c - 'A' + 27;
    return 0;
}
