module day15;

import std.stdio;
import std.string;
import std.conv;
import std.algorithm;
import std.math;
import util;

void main(string[] args)
{
    writeln("aoc22 day 15");
    auto lines = readLines("input/15.txt");
    auto sensorsAndBeacons = parseSensorsAndBeacons(lines);

    auto part1 = beaconsCannotBeAt(sensorsAndBeacons, 2_000_000);
    writeln("part 1: ", part1);

    auto part2 = beaconTuningFrequency(sensorsAndBeacons, 2 * 2_000_000);
    writeln("part 2: ", part2);
}

long beaconTuningFrequency(SensorBeacon[] sensorsAndBeacons, int maxPos)
{
    Range[] ranges;
    foreach (sb; sensorsAndBeacons)
    {
        auto dist = sb.sensor.manhattanDistance(sb.beacon) + 1;
        auto dirs = [Point(1, 0), Point(0, 1), Point(-1, 0), Point(0, -1)];
        for (auto i = 0; i < dirs.length; i++)
        {
            auto a = dirs[i];
            auto b = dirs[(i + 1) % dirs.length];
            Range range;
            range.begin = sb.sensor + (a * dist);
            range.end = sb.sensor + (b * dist);
            ranges ~= range;
        }
    }

    Point beacon;
    outer: foreach (range; ranges)
    {
        auto len = max(abs(range.end.row - range.begin.row), abs(range.end.col - range.begin.col));
        auto dir = (range.end - range.begin) / len;
        for (int i = 1; i < len; i++)
        {
            bool found = true;
            Point p = range.begin + dir * i;
            if (!(p.row >= 0 && p.col >= 0 && p.row <= maxPos && p.col <= maxPos))
            {
                continue;
            }
            foreach (sb; sensorsAndBeacons)
            {
                auto reach = sb.sensor.manhattanDistance(sb.beacon);
                auto dist = p.manhattanDistance(sb.sensor);
                if (dist < reach)
                {
                    found = false;
                    break;
                }
            }
            if (found)
            {
                beacon = p;
                break outer;
            }
        }
    }
    return cast(long) beacon.col * cast(long) maxPos + cast(long) beacon.row;
}

struct Range
{
    Point begin, end;
}

int beaconsCannotBeAt(SensorBeacon[] sensorsAndBeacons, int y)
{
    bool[Point] definitelyNotHere;
    foreach (sensorAndBeacon; sensorsAndBeacons)
    {
        int dist = sensorAndBeacon.sensor.manhattanDistance(sensorAndBeacon.beacon);
        if ((sensorAndBeacon.sensor.row - dist) <= y && y <= (sensorAndBeacon.sensor.row + dist))
        {
            int distToLine = abs(sensorAndBeacon.sensor.row - y);
            int span = (dist - distToLine);
            for (auto dx = -span; dx <= span; dx++)
            {
                definitelyNotHere[Point(y, sensorAndBeacon.sensor.col + dx)] = true;
            }
            definitelyNotHere.remove(sensorAndBeacon.beacon);
        }
    }
    return definitelyNotHere.length;
}

struct SensorBeacon
{
    Point sensor, beacon;
}

SensorBeacon[] parseSensorsAndBeacons(string[] lines)
{
    SensorBeacon[] result;

    foreach (line; lines)
    {
        auto split = line.split(": ");
        auto pos = split[0].split(", ");
        SensorBeacon s;
        s.sensor.col = pos[0][12 .. $].to!int;
        s.sensor.row = pos[1][2 .. $].to!int;
        pos = split[1].split(", ");
        s.beacon.col = pos[0][23 .. $].to!int;
        s.beacon.row = pos[1][2 .. $].to!int;
        result ~= s;
    }

    return result;
}
