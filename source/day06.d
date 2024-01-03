module day06;

import std.stdio;
import util;

void main(string[] args)
{
    writeln("aoc22 day 06");
    auto input = readLines("input/06.txt");

    writeln("part 1: ", findMarker(input[0], 4));
    writeln("part 2: ", findMarker(input[0], 14));
}

int findMarker(string input, int range)
{
    for (int i = range; i < input.length; i++)
    {
        dchar[dchar] hashset;
        foreach (key; input[i - range .. i])
        {
            hashset[key] = key;
        }

        if (hashset.length == range)
        {
            return i;
        }
    }
    return -1;
}
