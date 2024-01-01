module util;

import std.stdio, std.string, std.conv, std.algorithm, std.array;

string[] readLines(string file)
{
    return File(file).byLineCopy.map!strip.array;
}

struct Point
{
    int row, col;

    Point opBinary(string op)(Point other)
    {
        static if (op == "+")
            return Point(this.row + other.row, this.col + other.col);
        else static if (op == "-")
            return Point(this.row - other.row, this.col - other.col);
    }

    Point opUnary(string op)() if (op == "-")
    {
        return Point(-this.row, -this.col);
    }
}
