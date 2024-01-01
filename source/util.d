module util;

import std.stdio, std.string, std.conv, std.algorithm, std.array, std.math;

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

    Point opBinary(string op)(int factor)
    {
        static if (op == "*")
            return Point(this.row * factor, this.col * factor);
        else static if (op == "/")
            return Point(this.row / factor, this.col / factor);
    }

    Point opUnary(string op)() if (op == "-")
    {
        return Point(-this.row, -this.col);
    }

    int manhattanDistance(Point other)
    {
        return abs(this.col - other.col) + abs(this.row - other.row);
    }
}
