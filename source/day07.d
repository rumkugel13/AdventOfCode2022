module day07;

import std.stdio, std.array, std.string, std.conv, std.algorithm;
import util;

void main(string[] args)
{
    writeln("aoc22 day 07");
    auto input = readLines("input/07.txt");

    int[string] filesystem;
    string path = "";

    foreach (line; input)
    {
        auto parts = split(line);

        if (line[0] == '$')
        {
            if (parts[1] == "cd")
            {
                if (parts[2] == "..")
                {
                    path = path[0 .. lastIndexOf(path, '/')];
                    if (path.length == 0)
                        path = "/";
                }
                else if (parts[2] == "/")
                {
                    path = "/";
                }
                else
                {
                    path ~= (path == "/" ? "" : "/") ~ parts[2];
                }
            }
        }
        else
        {
            if (parts[0] != "dir")
            {
                int filesize = to!int(parts[0]);
                filesystem[path] += filesize;

                for (size_t i = lastIndexOf(path, '/'); i > 0; i = lastIndexOf(path[0 .. i], '/'))
                {
                    filesystem[path[0 .. i]] += filesize;
                }

                // this case is not covered in loop above
                if (path != "/")
                {
                    filesystem["/"] += filesize;
                }
            }
        }
    }

    // writeln(filesystem);

    int sum = 0;
    foreach (key; filesystem.values)
    {
        if (key < 100_000)
        {
            sum += key;
        }
    }

    writeln("part 1: ", sum);

    const int total = 70_000_000;
    const int needed = 30_000_000;
    const int currentfree = total - filesystem["/"];
    int result = int.max;

    foreach (key; filesystem.values)
    {
        if (currentfree + key >= needed)
        {
            result = min(result, key);
        }
    }

    writeln("part 2: ", result);
}
