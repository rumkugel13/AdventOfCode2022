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
