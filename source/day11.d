module day11;

import std.stdio, std.string, std.conv, std.algorithm, std.array;
import util;

void main(string[] args)
{
    writeln("aoc22 day 11");
    auto lines = readLines("input/11.txt");

    Monkey[] part1, part2;
    ulong modulo = 1;

    for (int i = 0; i < lines.length; i += 7)
    {
        Monkey temp = new Monkey();
        temp.items = array(lines[i + 1].split(':')[1].split(',').map!(a => to!ulong(strip(a))));
        temp.op = lines[i + 2].split()[$ - 3 .. $];
        temp.test = lines[i + 3].split("by")[1].strip().to!int();
        modulo *= temp.test;
        temp.target = [
            lines[i + 4].split("monkey")[1].strip().to!int(),
            lines[i + 5].split("monkey")[1].strip().to!int()
        ];
        part1 ~= temp;
        part2 ~= temp.dup();
    }

    auto results = doRounds(part1, false);

    writeln(results[0], " ", results[1]);
    writeln("part 1: ", results[0] * results[1]);

    results = doRounds(part2, true, modulo);

    writeln(results[0], " ", results[1]);
    writeln("part 2: ", results[0] * results[1]);
}

ulong[] doRounds(Monkey[] monkeys, bool part2, ulong modulo = 0)
{
    foreach (round; 0 .. part2 ? 10_000 : 20)
    {
        foreach (monkey; monkeys)
        {
            monkey.inspect += monkey.items.length;
            foreach (item; monkey.items)
            {
                if (monkey.op[1] == "+")
                {
                    item += isNumeric(monkey.op[2]) ? to!int(monkey.op[2]) : item;
                }
                else if (monkey.op[1] == "*")
                {
                    item *= isNumeric(monkey.op[2]) ? to!int(monkey.op[2]) : item;
                }

                if (!part2)
                    item /= 3;
                else
                    item %= modulo;

                monkeys[monkey.target[item % monkey.test == 0 ? 0: 1]].items ~= item;
            }
            monkey.items.length = 0;
        }
    }

    ulong[] counts;
    monkeys.each!(m => counts ~= m.inspect);
    return counts.sort().array().reverse()[0 .. 2];
}

class Monkey
{
    ulong[] items;
    string[] op;
    int test;
    int[2] target;
    int inspect = 0;

    Monkey dup() const
    {
        Monkey monkey = new Monkey();
        monkey.items = items.dup();
        monkey.op = op.dup();
        monkey.test = test;
        monkey.target = target.dup();
        monkey.inspect = 0;
        return monkey;
    }
}
