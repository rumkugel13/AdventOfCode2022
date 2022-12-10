module day10;

import std.stdio, std.string, std.conv;

void main(string[] args)
{
    writeln("aoc22 day 10");

    int X = 1;
    int cycle = 0;
    int result = 0;

    foreach (line; input.splitLines())
    {
        auto parts = line.split();
        switch (parts[0])
        {
        case "noop":
            cycle++;
            if ((cycle + 20) % 40 == 0)
                result += cycle * X;
            break;
        case "addx":
            foreach (_; 0 .. 2)
            {
                cycle++;
                if ((cycle + 20) % 40 == 0)
                    result += cycle * X;
            }
            X += to!int(parts[1]);
            break;
        default:
            break;
        }
    }

    writeln("part 1: ", result);

    X = 1;
    cycle = 0;

    foreach (line; input.splitLines())
    {
        auto parts = line.split();
        switch (parts[0])
        {
        case "noop":
            {
                auto col = cycle % 40;
                cycle++;
                write((col == X || col == X - 1 || col == X + 1) ? "#" : ".");
                if (col == 39)
                    writeln();
            }
            break;
        case "addx":
            foreach (_; 0 .. 2)
            {
                auto col = cycle % 40;
                cycle++;
                write((col == X || col == X - 1 || col == X + 1) ? "#" : ".");
                if (col == 39)
                    writeln();
            }
            X += to!int(parts[1]);
            break;
        default:
            break;
        }
    }

    writeln("part 2: look above");
}

string input = "noop
noop
addx 5
noop
noop
addx 1
addx 3
addx 2
addx 4
addx 3
noop
addx 2
addx 1
noop
noop
addx 4
noop
addx 1
addx 2
addx 5
addx 3
noop
addx -1
addx -37
addx 37
addx -34
addx 7
noop
addx -2
addx 2
noop
noop
noop
addx 5
addx 2
noop
addx 3
addx 15
addx -8
addx -9
addx 21
addx -9
addx 5
addx 2
addx 3
addx -2
addx -38
noop
addx 3
addx 37
addx -33
addx 5
noop
noop
addx 5
noop
noop
addx 5
noop
addx -1
addx 1
addx 5
noop
noop
addx 5
noop
noop
noop
addx 1
addx 2
noop
addx 3
addx -36
noop
noop
noop
addx 6
addx 21
addx -17
addx 18
addx -8
addx -7
addx 2
addx 5
addx -8
addx 13
addx -2
addx 7
noop
addx -2
addx 5
addx 2
addx 1
noop
addx -38
addx 4
addx 3
noop
addx 34
addx -29
addx -2
addx 10
addx -3
addx 2
addx 3
noop
addx -22
addx 2
addx 23
addx 7
noop
noop
addx 3
noop
addx 2
addx -18
addx 19
addx -38
addx 5
addx 2
noop
addx 1
addx 4
addx 1
noop
noop
addx 2
addx 5
addx 2
noop
addx 1
noop
addx 2
addx 8
addx -1
addx -30
addx 31
addx 2
addx 5
addx -35
noop";
