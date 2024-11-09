module day17;

import std.stdio;
import std.algorithm;
import util;

static void day17()
{
    writeln("aoc22 day 17");
    auto input = util.readLines("input/17.txt");
    string[][] rocks =
        [
            [
                "....",
                "....",
                "....",
                "####",
            ],
            [
                "....",
                ".#..",
                "###.",
                ".#..",
            ],
            [
                "....",
                "..#.",
                "..#.",
                "###.",
            ],
            [
                "#...",
                "#...",
                "#...",
                "#...",
            ],
            [
                "....",
                "....",
                "##..",
                "##..",
            ]
        ];

    char[Point] chamber;
    const auto width = 7;
    auto pattern = input[0];

    int height = 3;
    int maxHeight = 0;
    int left = 2;
    int rock = 0;
    int jet = 0;

    while (rock < 2022)
    {
        auto current = rocks[(rock++) % rocks.length];
        left = 2;

        while (true)
        {
            auto dir = (pattern[(jet++) % pattern.length] == '<') ? -1 : +1;
            if (canMoveHor(current, chamber, height, left, dir))
            {
                left += dir;
            }

            if (!canMoveDown(current, chamber, height, left))
            {
                maxHeight = max(maxHeight, placeBlock(current, &chamber, height, left));
                height = maxHeight + 4;
                break;
            }
            else
            {
                height--;
            }
        }
    }

    // printChamber(chamber, height);

    writeln("part 1: ", maxHeight + 1);
    writeln("part 2: ", 0);
}

void printChamber(char[Point] chamber, int height)
{
    for (int i = height; i >= 0; i--)
    {
        for (int col = 0; col < 7; col++)
        {
            if (Point(i, col) in chamber)
            {
                write("#");
            }
            else
            {
                write(".");
            }
        }
        writeln();
    }
}

int placeBlock(string[] rock, char[Point]* chamber, int height, int left)
{
    int maxHeight = 0;
    foreach_reverse (y, line; rock)
    {
        foreach (x, c; line)
        {
            if (c == '.')
                continue;
            auto point = Point(cast(int)(rock.length - y - 1) + height, cast(int)x + left);
            (*chamber)[point] = c;
            maxHeight = max(maxHeight, point.row);
        }
    }
    return maxHeight;
}

bool canMoveHor(string[] rock, char[Point] chamber, int height, int left, int dir)
{
    foreach_reverse (y, line; rock)
    {
        foreach (x, c; line)
        {
            if (c == '.')
                continue;
            auto check = Point(cast(int)(rock.length - y - 1) + height, cast(int)x + left + dir);
            if (check.col < 0 || check.col > 6 || check in chamber)
            {
                return false;
            }
        }
    }

    return true;
}

bool canMoveDown(string[] rock, char[Point] chamber, int height, int left)
{
    foreach_reverse (y, line; rock)
    {
        foreach (x, c; line)
        {
            if (c == '.')
                continue;
            auto check = Point(cast(int)(rock.length - y - 1) + height - 1, cast(int)x + left);
            if (check in chamber || check.row < 0)
            {
                return false;
            }
        }
    }

    return true;
}
