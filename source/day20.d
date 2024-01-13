module day20;

import std.stdio;
import util;
import std.conv;
import std.array;
import std.algorithm;

void day20()
{
    writeln("aoc22 day 20");

    auto input = readLines("input/20.txt");

    Item[] numbers;
    foreach (i, value; input)
    {
        numbers ~= Item(value.to!long, i);
    }

    writeln("part 1: ", mixer(numbers, 1, 1));
    writeln("part 2: ", mixer(numbers, 10, 811_589_153));
}

struct Item
{
    long number, index;
}

long mixer(Item[] numbers, int times, long key)
{
    foreach (ref n; numbers)
    {
        n.number *= key;
    }
    auto mix = numbers.dup;

    foreach (_; 0 .. times)
        foreach (num; numbers)
        {
            size_t idx = mix.countUntil!("a.index == b.index")(num);
            size_t newIdx = cast(uint) mod(idx + num.number, numbers.length - 1u);
            mix = mix[0 .. idx] ~ mix[idx + 1 .. $];
            mix = mix[0 .. newIdx] ~ num ~ mix[newIdx .. $];
        }

    size_t zeroIdx = mix.countUntil!("a.number == 0")(Item(0, 0));

    auto num1 = mix[mod(zeroIdx + 1000, mix.length)].number,
    num2 = mix[mod(zeroIdx + 2000, mix.length)].number,
    num3 = mix[mod(zeroIdx + 3000, mix.length)].number;
    return num1 + num2 + num3;
}
