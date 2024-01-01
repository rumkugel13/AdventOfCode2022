module day01;

import std.stdio;
import std.array;
import std.conv;
import util;

void main()
{
    writeln("aoc22 day01");

    auto input = readLines("input/01.txt");

    int max = int.min;
    int temp = 0;

    foreach (key; input)
    {
        if (key.length == 0)
        {
            if (temp > max)
                max = temp;
            temp = 0;
        }
        else
        {
            temp += to!int(key);
        }
    }

    writeln("part 1: ", max);

    int max1 = int.min;
    int max2 = int.min;
    int max3 = int.min;
    temp = 0;

    foreach (key; input)
    {
        if (key.length == 0)
        {
            if (temp > max1)
            {
                max3 = max2;
                max2 = max1;
                max1 = temp;
            }
            else if (temp > max2)
            {
                max3 = max2;
                max2 = temp;
            }
            else if (temp > max3)
            {
                max3 = temp;
            }

            temp = 0;
        }
        else
        {
            temp += to!int(key);
        }
    }

    writeln("part 2: ", max1 + max2 + max3);
}
