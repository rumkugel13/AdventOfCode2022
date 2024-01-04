module day02;

import std.stdio, std.array;
import util;

void day02()
{
    writeln("aoc22 day02");

    auto input = readLines("input/02.txt");

    int score = 0;

    foreach (key; input)
    {
        switch (key)
        {
            case "A X": score += 1 + 3; break;
            case "A Y": score += 2 + 6; break;
            case "A Z": score += 3 + 0; break;
            case "B X": score += 1 + 0; break;
            case "B Y": score += 2 + 3; break;
            case "B Z": score += 3 + 6; break;
            case "C X": score += 1 + 6; break;
            case "C Y": score += 2 + 0; break;
            case "C Z": score += 3 + 3; break;
            default:break;
        }
    }

    writeln("part 1: ", score);

    score = 0;

    foreach (key; input)
    {
        switch (key)
        {
            case "A X": score += 3 + 0; break;
            case "A Y": score += 1 + 3; break;
            case "A Z": score += 2 + 6; break;
            case "B X": score += 1 + 0; break;
            case "B Y": score += 2 + 3; break;
            case "B Z": score += 3 + 6; break;
            case "C X": score += 2 + 0; break;
            case "C Y": score += 3 + 3; break;
            case "C Z": score += 1 + 6; break;
            default:break;
        }
    }

    writeln("part 2: ", score);
}
