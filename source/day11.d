module day11;

import std.stdio, std.string, std.conv, std.algorithm, std.array;

void main(string[] args)
{
    writeln("aoc22 day 11");

//     input = "Monkey 0:
//   Starting items: 79, 98
//   Operation: new = old * 19
//   Test: divisible by 23
//     If true: throw to monkey 2
//     If false: throw to monkey 3

// Monkey 1:
//   Starting items: 54, 65, 75, 74
//   Operation: new = old + 6
//   Test: divisible by 19
//     If true: throw to monkey 2
//     If false: throw to monkey 0

// Monkey 2:
//   Starting items: 79, 60, 97
//   Operation: new = old * old
//   Test: divisible by 13
//     If true: throw to monkey 1
//     If false: throw to monkey 3

// Monkey 3:
//   Starting items: 74
//   Operation: new = old + 3
//   Test: divisible by 17
//     If true: throw to monkey 0
//     If false: throw to monkey 1";

    class Monkey
    {
        int[] items;
        string op;
        int test;
        int[2] target;
        int inspect = 0;

        void write()
        {
            writeln(items, ",", op, ",", test, ",", target, ",", inspect);
        }
    }

    Monkey[] monkeys;
    auto lines = input.splitLines();

    for (int i = 0; i < lines.length; i += 7)
    {
        Monkey temp = new Monkey();
        temp.items = array(lines[i + 1].split(':')[1].split(',').map!(a => to!int(strip(a))));
        temp.op = lines[i + 2].split('=')[1].strip();
        temp.test = lines[i + 3].split("by")[1].strip().to!int();
        temp.target = [
            lines[i + 4].split("monkey")[1].strip.to!int(),
            lines[i + 5].split("monkey")[1].strip.to!int()
        ];
        monkeys ~= temp;
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

    int max1, max2;
    foreach (monkey; monkeys)
    {
        max1 = max(max1, max2);
        max2 = max(max2, monkey.inspect);
    }

    writeln("part 1: ", max1 * max2);

    writeln("part 2: ");
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
