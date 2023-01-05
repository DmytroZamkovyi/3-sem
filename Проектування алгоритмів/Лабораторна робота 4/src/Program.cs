using System;
using System.Collections.Generic;
using System.Text;

namespace ConsoleApp4 {
    class backpack {
        public bool[] items;
        public backpack(int amount) {
            items = new bool[amount];
        }
        public backpack(backpack bp) {
            this.items = bp.items;
        }

        public void print() {
            Console.Write("{");
            for (int i = 0; i < this.items.Length; ++i) {
                if (this.items[i]) Console.Write("1");
                else Console.Write(".");
            }
            Console.WriteLine("}\nCost: " + Program.get_total_cost(this) + "\nWeight: " + Program.get_total_weight(this));
        }

        public static bool operator ==(backpack bp1, backpack bp2) {
            for (int i = 0; i < bp1.items.Length; ++i) {
                if (bp1.items[i] != bp2.items[i]) return false;
            }
            return true;
        }

        public static bool operator !=(backpack bp1, backpack bp2) {
            return !(bp1 == bp2);
        }
    }

    class item {
        public int weight { get; set; }
        public int cost { get; set; }

        public item() {
            var rand = new Random();
            weight = rand.Next(2, 11);
            cost = rand.Next(1, 6);
        }
    }

    class Program {
        public const int CAPACITY = 150;
        public const int AMOUNT = 100;
        public const int NUMBER_OF_ITERATIONS = 1000;
        
        public static item[] item_list = create_items(AMOUNT);
        
        static void Main(string[] args) {

            var backpacks = init_backpacks(AMOUNT);
            print_items(item_list);
            backpacks = genetic_algo(backpacks);
            Console.WriteLine("\nBest item:");
            backpacks[get_best_index(backpacks)].print();
        }

        static backpack[] genetic_algo(backpack[] backpacks) {
            for (int i = 0; i < NUMBER_OF_ITERATIONS; ++i) {
                backpacks = genetic_iteration(backpacks);
            }
            return backpacks;
        }

        static backpack[] genetic_iteration(backpack[] backpacks) {
            (var best_bp, var random_bp) = choose_ancestors(backpacks);

            var child = crossing_genes(best_bp, random_bp);
            var mutated = mutate(child);

            if (get_total_weight(child) > CAPACITY && get_total_weight(mutated) > CAPACITY) return backpacks;
            var improved = local_improvement(child, mutated);

            var best = choose_best(child, mutated, improved);
            int worst_index = get_worst_index(backpacks);
            backpacks[worst_index] = best;
            return backpacks;
        }

        static int get_worst_index(backpack[] backpacks) {
            int worst_cost = int.MaxValue;
            int worst_index = -1;
            for (int i = 0; i < AMOUNT; ++i) {
                if (get_total_cost(backpacks[i]) < worst_cost) {
                    worst_cost = get_total_cost(backpacks[i]);
                    worst_index = i;
                }
            }
            return worst_index;
        }

        static backpack choose_best(backpack child, backpack mutated, backpack improved) {
            if (get_total_weight(child) > CAPACITY) {
                if (get_total_weight(improved) > CAPACITY) return mutated;
                if (get_total_cost(mutated) > get_total_cost(improved)) return mutated;
                else return improved;
            }
            else if (get_total_weight(mutated) > CAPACITY) {
                if (get_total_weight(improved) > CAPACITY) {
                    return child;
                }
                if (get_total_cost(child) > get_total_cost(improved)) return child;
                else return improved;
            }
            else if (get_total_weight(improved) > CAPACITY) {
                if (get_total_cost(mutated) > get_total_cost(child)) return mutated;
                else return child;
            }
            else {
                int maxCost = Math.Max(get_total_cost(child), Math.Max(get_total_cost(mutated), get_total_cost(improved)));
                if (maxCost == get_total_cost(improved)) return improved;
                else if (maxCost == get_total_cost(mutated)) return mutated;
                else return child;
            }
        }

        static backpack local_improvement(backpack child, backpack mutated) {
            if (get_total_weight(mutated) > CAPACITY) {
                if (get_total_weight(child) <= CAPACITY) {
                    return improve(child);
                }
            }
            else{
                if (get_total_weight(child) <= CAPACITY) {
                    if (get_total_cost(child) >= get_total_cost(mutated))
    {
                        return improve(child);
                    }
                    else
    {
                        return improve(mutated);
                    }
                }
                else{
                    return improve(mutated);
                }
            }
            return null;
        }

        static backpack improve(backpack bp) {
            var result = new backpack(bp);
            if (result.items[get_best_item_index()] == false) {
                result.items[get_best_item_index()] = true;
            }
            return result;
        }

        static int get_best_item_index() {
            double best_benefit = 0;
            int best_index = -1;
            for (int i = 0; i < AMOUNT; ++i) {
                if (item_list[i].cost / item_list[i].weight > best_benefit) {
                    best_benefit = item_list[i].cost / item_list[i].weight;
                    best_index = i;
                }
            }
            return best_index;
        }

        static backpack mutate(backpack bp) {
            var rand = new Random();
            if (rand.NextDouble() > 0.1) {
                int rand_index1 = rand.Next(0, bp.items.Length);
                int rand_index2 = rand.Next(0, bp.items.Length);
                while (rand_index1 == rand_index2) {
                    rand_index2 = rand.Next(0, bp.items.Length);
                }

                bool tmp = bp.items[rand_index1];
                bp.items[rand_index1] = bp.items[rand_index2];
                bp.items[rand_index2] = tmp;
            }
            return bp;
        }

        static backpack crossing_genes(backpack bp1, backpack bp2) {
            var rand = new Random();
            var backpack_res = new backpack(AMOUNT);
            for (int i = 0; i < bp1.items.Length; ++i) {
                if (rand.NextDouble() < 0.5) {
                    backpack_res.items[i] = bp1.items[i];
                }
                else{
                    backpack_res.items[i] = bp2.items[i];
                }
            }
            return backpack_res;
        }

        static (backpack, backpack) choose_ancestors(backpack[] backpacks) {
            int best_index = get_best_index(backpacks);
            var best_bp = backpacks[best_index];

            var rand = new Random();
            int random_index = rand.Next(0, backpacks.Length);
            while (random_index == best_index) {
                random_index = rand.Next(0, backpacks.Length);
            }
            var random_bp = backpacks[random_index];

            return (best_bp, random_bp);
        }

        static int get_best_index(backpack[] bps) {
            int best_index = -1;
            int best_cost = 0;
            for (int i = 0; i < bps.Length; ++i) {
                if (get_total_cost(bps[i]) > best_cost) {
                    best_cost = get_total_cost(bps[i]);
                    best_index = i;
                }
            }
            return best_index;
        }

        static item[] create_items(int amount) {
            item[] items = new item[amount];
            for (int i = 0; i < items.Length; ++i) {
                items[i] = new item();
            }
            return items;
        }

        static backpack[] init_backpacks(int amount) {
            backpack[] backpacks = new backpack[amount];
            for (int i = 0; i < backpacks.Length; ++i) {
                backpacks[i] = new backpack(AMOUNT);
                backpacks[i].items[i] = true;
            }
            return backpacks;
        }

        static void print_items(item[] items) {
            Console.Write("Weights:\n");
            foreach (var item in items) {
                Console.Write(item.weight + " ");
            }
            Console.Write("\n\nCosts:\n");
            foreach (var item in items) {
                Console.Write(item.cost + " ");
            }
            Console.WriteLine();
        }

        public static int get_total_cost(backpack bp) {
            int totalCost = 0;
            for (int i = 0; i < bp.items.Length; ++i) {
                if (bp.items[i]) totalCost += item_list[i].cost;
            }
            return totalCost;
        }

        public static int get_total_weight(backpack bp) {
            int totalWeight = 0;
            for (int i = 0; i < bp.items.Length; ++i) {
                if (bp.items[i]) totalWeight += item_list[i].weight;
            }
            return totalWeight;
        }

    }
}