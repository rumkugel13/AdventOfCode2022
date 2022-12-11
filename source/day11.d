module day11;

import std.stdio, std.string, std.conv, std.algorithm, std.array;

void main(string[] args)
{
    writeln("aoc22 day 11");

    class Monkey
    {
        ulong[] items;
        string op;
        int test;
        int[2] target;
        int inspect = 0;

        void write()
        {
            writeln(items, ",", op, ",", test, ",", target, ",", inspect);
        }

        Monkey dup() const
        {
            Monkey monkey = new Monkey();
            monkey.items = items.dup();
            monkey.op = op;
            monkey.test = test;
            monkey.target = target.dup();
            monkey.inspect = 0;
            return monkey;
        }
    }

    Monkey[] monkeys, part2;
    auto lines = input.splitLines();
    ulong modulo = 1;

    for (int i = 0; i < lines.length; i += 7)
    {
        Monkey temp = new Monkey();
        temp.items = array(lines[i + 1].split(':')[1].split(',').map!(a => to!ulong(strip(a))));
        temp.op = lines[i + 2].split('=')[1].strip();
        temp.test = lines[i + 3].split("by")[1].strip().to!int();
        modulo *= temp.test;
        temp.target = [
            lines[i + 4].split("monkey")[1].strip.to!int(),
            lines[i + 5].split("monkey")[1].strip.to!int()
        ];
        monkeys ~= temp;
        part2 ~= temp.dup();
    }

    const int rounds = 20;
    foreach (round; 0 .. rounds)
    {
        foreach (monkey; monkeys)
        {
            monkey.inspect += monkey.items.length;
            foreach (item; monkey.items)
            {
                auto op = monkey.op.split();
                switch (op[1])
                {
                case "+":
                    if (isNumeric(op[2]))
                        item += to!int(op[2]);
                    else
                        item += item;
                    break;
                case "*":
                    if (isNumeric(op[2]))
                        item *= to!int(op[2]);
                    else
                        item *= item;
                    break;
                default:
                    break;
                }
                item /= 3;

                monkeys[monkey.target[item % monkey.test == 0 ? 0: 1]].items ~= item;
            }
            monkey.items.length = 0;
        }
    }

    ulong[] counts;
    foreach (monkey; monkeys)
    {
        counts ~= monkey.inspect;
    }

    auto results = counts.sort().reverse();

    writeln(results[0], " ", results[1]);
    writeln("part 1: ", results[0] * results[1]);

    foreach (round; 0 .. 10_000)
    {
        foreach (monkey; part2)
        {
            monkey.inspect += monkey.items.length;
            foreach (item; monkey.items)
            {
                auto op = monkey.op.split();
                switch (op[1])
                {
                case "+":
                    if (isNumeric(op[2]))
                        item += to!int(op[2]);
                    else
                        item += item;
                    break;
                case "*":
                    if (isNumeric(op[2]))
                        item *= to!int(op[2]);
                    else
                        item *= item;
                    break;
                default:
                    break;
                }

                item %= modulo;

                part2[monkey.target[item % monkey.test == 0 ? 0: 1]].items ~= item;
            }
            monkey.items.length = 0;
        }
    }

    counts.length = 0;
    foreach (monkey; part2)
    {
        counts ~= monkey.inspect;
    }

    results = counts.sort().reverse();

    writeln(results[0], " ", results[1]);
    writeln("part 2: ", results[0] * results[1]);
}

string input = "Monkey 0:
  Starting items: 71, 86
  Operation: new = old * 13
  Test: divisible by 19
    If true: throw to monkey 6
    If false: throw to monkey 7

Monkey 1:
  Starting items: 66, 50, 90, 53, 88, 85
  Operation: new = old + 3
  Test: divisible by 2
    If true: throw to monkey 5
    If false: throw to monkey 4

Monkey 2:
  Starting items: 97, 54, 89, 62, 84, 80, 63
  Operation: new = old + 6
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 1

Monkey 3:
  Starting items: 82, 97, 56, 92
  Operation: new = old + 2
  Test: divisible by 5
    If true: throw to monkey 6
    If false: throw to monkey 0

Monkey 4:
  Starting items: 50, 99, 67, 61, 86
  Operation: new = old * old
  Test: divisible by 7
    If true: throw to monkey 5
    If false: throw to monkey 3

Monkey 5:
  Starting items: 61, 66, 72, 55, 64, 53, 72, 63
  Operation: new = old + 4
  Test: divisible by 11
    If true: throw to monkey 3
    If false: throw to monkey 0

Monkey 6:
  Starting items: 59, 79, 63
  Operation: new = old * 7
  Test: divisible by 17
    If true: throw to monkey 2
    If false: throw to monkey 7

Monkey 7:
  Starting items: 55
  Operation: new = old + 7
  Test: divisible by 3
    If true: throw to monkey 2
    If false: throw to monkey 1";
