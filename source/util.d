module util;

import std.stdio, std.string, std.conv, std.algorithm, std.array;

string[] readLines(string file)
{
    return File(file).byLineCopy.map!strip.array;
}

struct Point {
    int row, col;
}