module day13;

import std.stdio, std.string, std.array, std.algorithm, std.container;
import util;

void main(string[] args)
{
    writeln("aoc22 day 13");
    auto lines = readLines("input/13.txt");

    auto input = "[1,1,3,1,1]
[1,1,5,1,1]

[[1],[2,3,4]]
[[1],4]

[9]
[[8,7,6]]

[[4,4],4,4]
[[4,4],4,4,4]

[7,7,7,7]
[7,7,7]

[]
[3]

[[[]]]
[[]]

[1,[2,[3,[4,[5,6,7]]]],8,9]
[1,[2,[3,[4,[5,6,0]]]],8,9]";

    lines = input.splitLines();
    Pair[] pairs;

    for (int i = 0; i < lines.length; i+=3)
    {
        auto left = lines[i];
        auto right = lines[i+1];
        pairs ~= Pair(left, right);
    }

    auto part1 = 0;
    foreach (i, pair; pairs)
    {
        if (checkOrder(pair))
            part1 += (i + 1);
    }

    writeln("part 1: ", part1);

    writeln("part 2: ", 0);
}

struct Pair {
    string a, b;
}

bool checkOrder(Pair pair)
{
    int indexA, indexB;
    writeln("Pairs ", pair.a, pair.b);
    auto ok = checkList(pair, &indexA, &indexB);
    writeln("OK: ", ok);
    return ok;
}

bool checkList(Pair pair, int* indexA, int* indexB)
{
    while (++*indexA < pair.a.length && ++*indexB < pair.b.length)
    {
        char charA = pair.a[*indexA];
        char charB = pair.b[*indexB];
        writeln("comparing ", charA, " to ", charB);
        if (charA == '[' && charB == '[')
        {
            if (!checkList(pair, indexA, indexB))
            {
                return false;
            }
        }

        if (charA == ']' && charB == ']')
            break;

        if (charA == ',' && charB == ',')
            continue;
        
        if (charA == '[' && charB != '[')
        {
            //convert b to list
            ++*indexA;
            if (!checkList(pair, indexA, indexB))
            {
                return false;
            }
            continue;
        }
        if (charA != '[' && charB == '[')
        {
            //convert a to list
            ++*indexB;
            if (!checkList(pair, indexA, indexB))
            {
                return false;
            } 
            continue;
        }
        
        if (charA > charB)
            return false;
    }
    return true;
}
