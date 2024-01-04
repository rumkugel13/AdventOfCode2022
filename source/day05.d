module day05;

import std.stdio, std.algorithm, std.array, std.conv, std.uni, std.string;
import util;

void main(string[] args)
{
    writeln("aoc22 day 05");

    auto input = readLines("input/05.txt");
    char[][] crates, crates2;

    foreach (key; input)
    {
        if (crates.length == 0)
            crates2.length = crates.length = key.length / 4 + 1;

        if (key.length == 0 || isNumber(key[1]))
            continue;

        if (key[0] != 'm')
        {
            for (int i = 0; i < key.length; i += 4)
            {
                if (key[i + 1] != ' ')
                {
                    crates[i / 4] = key[i + 1] ~ crates[i / 4];
                    crates2[i / 4] = key[i + 1] ~ crates2[i / 4];
                }
            }
        }
        else
        {
            auto parts = split(key);
            auto amount = to!int(parts[1]);
            auto from = to!int(parts[3]) - 1;
            auto target = to!int(parts[5]) - 1;

            crates[target] ~= crates[from][$ - amount .. $].reverse();
            crates[from].length -= amount;

            crates2[target] ~= crates2[from][$ - amount .. $];
            crates2[from].length -= amount;
        }
    }

    write("part 1: ");
    foreach (key; crates)
    {
        write(key[$ - 1]);
    }
    writeln();

    write("part 2: ");
    foreach (key; crates2)
    {
        write(key[$ - 1]);
    }
    writeln();
}
