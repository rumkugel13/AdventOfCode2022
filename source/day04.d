module day04;

import std.algorithm, std.array, std.stdio, std.conv;
import util;

void main(string[] args)
{
    writeln("aoc22 day 04");
    auto input = readLines("input/04.txt");

    int contain = 0;
    int overlap = 0;

    foreach (line; input)
    {
        auto parts = split(line, ',');
        auto one = split(parts[0], '-');
        auto two = split(parts[1], '-');

        if ((to!int(one[0]) >= to!int(two[0]) && to!int(one[1]) <= to!int(two[1]))
            || (to!int(one[1]) >= to!int(two[1]) && to!int(one[0]) <= to!int(two[0])))
        {
            contain++;
        }

        if (max(to!int(one[0]), to!int(two[0])) <= min(to!int(one[1]), to!int(two[1])))
        {
            overlap++;
        }
    }

    writeln("part 1: ", contain);
    writeln("part 2: ", overlap);
}
