module day08;

import std.stdio, std.array, std.conv;
import util;

void main(string[] args)
{
    writeln("aoc22 day 08");

    auto grid = readLines("input/08.txt");
    const size_t rows = grid.length;
    const size_t cols = grid[0].length;
    writeln("rows: ", rows, " cols: ", cols);

    int count = 0;
    int maxScore = 0;

    foreach (y; 0 .. rows)
    {
        foreach (x; 0 .. cols)
        {
            const int height = grid[y][x] - '0';

            bool up = true;
            int upDistance = 0;
            foreach_reverse (yup; 0 .. y)
            {
                int temp = grid[yup][x] - '0';
                upDistance++;
                if (temp >= height)
                {
                    up = false;
                    break;
                }
            }

            bool down = true;
            int downDistance = 0;
            foreach (ydown; y + 1 .. rows)
            {
                int temp = grid[ydown][x] - '0';
                downDistance++;
                if (temp >= height)
                {
                    down = false;
                    break;
                }
            }

            bool left = true;
            int leftDistance = 0;
            foreach_reverse (xleft; 0 .. x)
            {
                int temp = grid[y][xleft] - '0';
                leftDistance++;
                if (temp >= height)
                {
                    left = false;
                    break;
                }
            }

            bool right = true;
            int rightDistance = 0;
            foreach (xright; x + 1 .. cols)
            {
                int temp = grid[y][xright] - '0';
                rightDistance++;
                if (temp >= height)
                {
                    right = false;
                    break;
                }
            }

            if (up || down || left || right)
                count++;

            int score = upDistance * downDistance * leftDistance * rightDistance;
            if (score > maxScore)
                maxScore = score;
        }
    }

    writeln("part 1: ", count);
    writeln("part 2: ", maxScore);
}
