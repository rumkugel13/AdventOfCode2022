module day10;

import std.stdio, std.string, std.conv;
import util;

void main(string[] args)
{
    writeln("aoc22 day 10");
    auto input = readLines("input/10.txt");

    int X = 1;
    int cycle = 0;
    int result = 0;

    foreach (line; input)
    {
        auto parts = line.split();

        foreach (_; 0 .. (parts[0] == "noop" ? 1 : 2))
        {
            cycle++;
            if ((cycle + 20) % 40 == 0)
                result += cycle * X;
        }

        if (parts[0] == "addx")
            X += to!int(parts[1]);
    }

    writeln("part 1: ", result);

    X = 1;
    cycle = 0;

    foreach (line; input)
    {
        auto parts = line.split();

        foreach (_; 0 .. (parts[0] == "noop" ? 1 : 2))
        {
            auto col = cycle++ % 40;
            write((col >= X - 1 && col <= X + 1) ? "##" : "  ");

            if (col == 39)
                writeln();
        }

        if (parts[0] == "addx")
            X += to!int(parts[1]);
    }

    writeln("part 2: look above");
}
