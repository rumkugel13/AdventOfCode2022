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

    struct item
    {
        int number, index;
    }

    item[] numbers;
    foreach (i, value; input)
    {
        numbers ~= item(value.to!int, i);
    }

    auto mix = numbers.dup;
    foreach (num; numbers)
    {
        size_t idx = std.algorithm.countUntil(mix, num);
        auto newIdx = mod(idx + num.number, numbers.length - 1);
        mix = mix[0 .. idx] ~ mix[idx + 1 .. $];
        mix = mix[0 .. newIdx] ~ num ~ mix[newIdx .. $];
    }

    size_t zeroIdx = std.algorithm.countUntil!("a.number == 0")(mix, item(0, 0));
    
    auto num1 = mix[mod(zeroIdx + 1000, mix.length)].number, 
        num2 = mix[mod(zeroIdx + 2000, mix.length)].number,
        num3 = mix[mod(zeroIdx + 3000, mix.length)].number;

    writeln("part 1: ", num1 + num2 + num3);
    writeln("part 2: ", 0);
}
