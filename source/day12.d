module day12;

import std.stdio, std.string, std.array, std.algorithm, std.container;
import util;

void day12()
{
    writeln("aoc22 day 12");
    auto lines = readLines("input/12.txt");

    struct Point
    {
        size_t x;
        size_t y;
    }

    Point start, end;
    Point[] ays;

    foreach (y, line; lines)
    {
        foreach (x, c; line)
        {
            if (c == 'S')
            {
                start.x = x;
                start.y = y;
            }
            if (c == 'E')
            {
                end.x = x;
                end.y = y;
            }
            if (c == 'a')
            {
                Point p = {x, y};
                ays ~= p;
            }
        }
    }

    writeln("width: ", lines[0].length, " height: ", lines.length);
    writeln("start: ", start, " end: ", end);

    Point[4] deltas = [{1, 0}, {-1, 0}, {0, 1}, {0, -1}];

    int[Point] distances = [end: 0];

    DList!Point queue;
    queue.insertBack(end);

    while (queue.opSlice().count > 0)
    {
        Point p = queue.front();
        queue.removeFront();

        auto check = p == start ? 'a' : p == end ? 'z' : lines[p.y][p.x];
        int dist = distances[p];

        foreach (delta; deltas)
        {
            Point temp = {p.x + delta.x, p.y + delta.y};
            if (temp.x >= 0 && temp.x < lines[0].length && temp.y >= 0 && temp.y < lines.length)
                if (temp == start ? 'a' : lines[temp.y][temp.x] - check >= -1)
                    if (temp !in distances)
                    {
                        queue.insertBack(temp);
                        distances[temp] = dist + 1;
                    }
        }
    }

    writeln("part 1: ", distances[start]);

    int min = int.max;
    foreach (a; ays)
    {
        if (a in distances && distances[a] < min)
            min = distances[a];
    }
    writeln("part 2: ", min);
}
