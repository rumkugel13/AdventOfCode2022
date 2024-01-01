module day14;

import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.math : abs;
import util;

void main(string[] args)
{
    writeln("aoc22 day 14");

    auto lines = readLines("input/14.txt");
    int floor = 0;
    auto cave = buildCave(lines, floor);
    auto sandUnits = solvePart1(cave, floor);

    writeln("part 1: ", sandUnits);

    cave = buildCave(lines, floor);
    auto part2 = solvePart2(cave, floor + 2);

    writeln("part 2: ", part2);
}

int solvePart2(char[Point] cave, int floor)
{
    auto sandUnits = 0;
    auto sand = Point(0, 500);
    while (true)
    {
        if (canMoveDir2(cave, sand, Point(1, 0), floor))
        {
            sand.row++;
            continue;
        }
        if (canMoveDir2(cave, sand, Point(1, -1), floor))
        {
            sand.row++;
            sand.col--;
            continue;
        }
        if (canMoveDir2(cave, sand, Point(1, 1), floor))
        {
            sand.row++;
            sand.col++;
            continue;
        }
        if (sand.row == 0 && sand.col == 500)
        {
            break;
        }
        cave[sand] = '+';
        sandUnits++;
        sand = Point(0, 500);
    }
    return sandUnits + 1;
}

bool canMoveDir2(char[Point] cave, Point sand, Point dir, int floor)
{
    Point newPoint = (sand + dir);
    return (newPoint in cave) is null && newPoint.row != floor;
}

int solvePart1(char[Point] cave, int floor)
{
    auto sandUnits = 0;
    auto sand = Point(0, 500);
    while (sand.row <= floor)
    {
        if (canMoveDir(cave, sand, Point(1, 0)))
        {
            sand.row++;
            continue;
        }
        if (canMoveDir(cave, sand, Point(1, -1)))
        {
            sand.row++;
            sand.col--;
            continue;
        }
        if (canMoveDir(cave, sand, Point(1, 1)))
        {
            sand.row++;
            sand.col++;
            continue;
        }
        cave[sand] = '+';
        sandUnits++;
        sand = Point(0, 500);
    }
    return sandUnits;
}

bool canMoveDir(char[Point] cave, Point sand, Point dir)
{
    Point newPoint = (sand + dir);
    return (newPoint in cave) is null;
}

char[Point] buildCave(string[] lines, out int floor)
{
    char[Point] cave;
    floor = 0;
    foreach (line; lines)
    {
        auto split = line.split(" -> ");
        Point[] points;
        foreach (part; split)
        {
            auto data = part.split(",");
            points ~= Point(data[1].to!int, data[0].to!int);
        }
        for (auto i = 0; i < points.length - 1; i++)
        {
            auto start = points[i];
            auto end = points[i + 1];
            auto amount = max(abs((end.row - start.row)), abs((end.col - start.col)));
            auto dir = Point((end.row - start.row) / amount, (end.col - start.col) / amount);
            for (auto row = start.row, col = start.col, j = 0; j <= amount; row += dir.row, col += dir.col, j++)
            {
                cave[Point(row, col)] = '#';
            }
            floor = max(floor, max(start.row, end.row));
        }
    }
    return cave;
}
