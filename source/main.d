module main;

import std.stdio;
import std.datetime.stopwatch;
import day01, day02, day03, day04, day05, day06, day07, day08, day09, day10;
import day11, day12, day14, day15, day17, day20;
import day21;

void main(string[] args)
{
    writeln("AoC22");

    void function()[] funcs = [
        &day01.day01, &day02.day02, &day03.day03, &day04.day04, &day05.day05,
        &day06.day06, &day07.day07, &day08.day08, &day09.day09, &day10.day10,
        &day11.day11, &day12.day12, &day14.day14, &day15.day15, &day17.day17,
        &day20.day20, &day21.day21
    ];

    StopWatch sw = StopWatch.init;
    sw.start();

    foreach (func; funcs)
    {
        func();
        writeln("Took: ", sw.peek());
        sw.reset();
    }

    sw.stop();
}
