module day09;

import std.stdio, std.string, std.conv, std.algorithm, std.math;
import util;

void day09()
{
    writeln("aoc22 day 09");
    auto input = readLines("input/09.txt");

    int[2] head, tail;

    int[int[2]] tailPos;
    tailPos[[0, 0]] = 0;

    foreach (line; input)
    {
        auto parts = line.split();
        int amount = to!int(parts[1]);
        int axis = 0;

        foreach (_; 0 .. amount)
        {
            head[0] += parts[0] == "R" ? 1 : parts[0] == "L" ? -1 : 0;
            head[1] += parts[0] == "D" ? 1 : parts[0] == "U" ? -1 : 0;
            axis = parts[0] == "R" || parts[0] == "L" ? 0 : 1;

            int other = (axis + 1) % 2;
            if (abs(head[axis] - tail[axis]) > 1)
            {
                if (head[other] - tail[other] != 0)
                {
                    tail[other] += head[other] - tail[other];
                }
                tail[axis] += sgn(head[axis] - tail[axis]);
            }

            tailPos[[tail[0], tail[1]]] = 0;
        }

    }

    writeln("part 1: ", tailPos.length);

    int[2][10] rope;

    tailPos.clear();
    tailPos[[0, 0]] = 0;

    foreach (line; input)
    {
        auto parts = line.split();
        int amount = to!int(parts[1]);

        foreach (_; 0 .. amount)
        {
            rope[0][0] += parts[0] == "R" ? 1 : parts[0] == "L" ? -1 : 0;
            rope[0][1] += parts[0] == "D" ? 1 : parts[0] == "U" ? -1 : 0;

            foreach (n; 0 .. abs(rope.length) - 1)
            {
                if (max(abs(rope[n][0] - rope[n + 1][0]), abs(rope[n][1] - rope[n + 1][1])) > 1)
                {
                    if (rope[n][1] - rope[n + 1][1] == 0)
                    {
                        rope[n + 1][0] += sgn(rope[n][0] - rope[n + 1][0]);
                    }
                    else if (rope[n][0] - rope[n + 1][0] == 0)
                    {
                        rope[n + 1][1] += sgn(rope[n][1] - rope[n + 1][1]);
                    }
                    else
                    {
                        rope[n + 1][1] += sgn(rope[n][1] - rope[n + 1][1]);
                        rope[n + 1][0] += sgn(rope[n][0] - rope[n + 1][0]);
                    }
                }
                else
                    break;
            }

            tailPos[[rope[9][0], rope[9][1]]] = 0;
        }
    }

    writeln("part 2: ", tailPos.length);
}
