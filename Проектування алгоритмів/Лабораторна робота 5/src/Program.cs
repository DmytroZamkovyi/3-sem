using System;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

namespace ConsoleApp5
{
    [Serializable]
    class Node
    {
        public int num;
        public bool captur;
        public List<int> nbs;

        public Node()
        {
            nbs = new List<int>();
            captur = false;
            num = -1;
        }

        public bool connect(Node nb, int max_c)
        {
            if (!(nb.nbs.Count == max_c) && !this.nbs.Contains(nb.num))
            {
                this.nbs.Add(nb.num);
                nb.nbs.Add(this.num);
                return true;
            }
            return false;
        }
    }

    class Program {
        const int AMOUNT_OF_NODES = 300;
        const int MAX_COUNT = 30;
        const int MIN_COUNT = 2;
        const int AGENT = 100;
        const int WORKERS = 300;

        static void Main(string[] args)
        {
            var G = create_graph(AMOUNT_OF_NODES, MAX_COUNT, MIN_COUNT);
            greedy_capture(ref G);
            Console.WriteLine("Before: " + rate_solution(G));
            bee_alghorithm(ref G);
            Console.WriteLine("After: " + rate_solution(G));
        }

        static void bee_alghorithm(ref Node[] G)
        {
            for (int i = 0; i < AGENT; ++i)
            {
                var rand = new Random();
                int rand_index = rand.Next(0, AMOUNT_OF_NODES);
                G = near_search(G, rand_index);
            }
        }

        static Node[] near_search(Node[] G, int index)
        {
            Node node = G[index];
            Node[] back_copy = deep_copy(G);
            for (int i = 0; i < WORKERS; ++i)
            {
                int max_degree = node.nbs.Count;
                int max_index = index;
                foreach (var neigh in node.nbs)
                {
                    if (G[neigh].nbs.Count > max_degree)
                    {
                        max_degree = G[neigh].nbs.Count;
                        max_index = neigh;
                    }
                }
                G[max_index].captur = true;
                for (int j = 0; j < G[max_index].nbs.Count; ++j)
                {
                    G[G[max_index].nbs[j]].captur = false;
                }
                greedy_capture(ref G);

            }
            if (rate_solution(G) > rate_solution(back_copy)) return back_copy;
            else return G;


        }

        public static T deep_copy<T>(T item)
        {
            BinaryFormatter formatter = new BinaryFormatter();
            MemoryStream stream = new MemoryStream();
            formatter.Serialize(stream, item);
            stream.Seek(0, SeekOrigin.Begin);
            T result = (T)formatter.Deserialize(stream);
            stream.Close();
            return result;
        }

        static int rate_solution(Node[] graph)
        {
            int res = 0;
            foreach (var node in graph)
            {
                if (node.captur) res++;
            }
            return res;
        }

        static bool is_covered(Node[] nodes, Node node)
        {
            if (node.captur) return true;
            for (int i = 0; i < node.nbs.Count; ++i)
            {
                if (nodes[node.nbs[i]].captur) return true;
            }
            return false;
        }

        static Node[] create_graph(int amount, int max_connections, int min_connections)
        {
            Node[] nodes = new Node[amount];
            for (int i = 0; i < amount; ++i)
            {
                nodes[i] = new Node();
                nodes[i].num = i;
            }
            Random rand = new Random();

            for (int i = 0; i < nodes.Length; ++i)
            {
                int num_connections = rand.Next(min_connections, max_connections);

                for (int j = nodes[i].nbs.Count; j < num_connections; ++j)
                {
                    int randIndex = rand.Next(0, nodes.Length);
                    if (randIndex == i)
                    {
                        if (randIndex == nodes.Length - 1)
                        {
                            randIndex = 0;
                        }
                        else
                        {
                            randIndex++;
                        }
                    }
                    if (!nodes[i].connect(nodes[randIndex], max_connections)) j--;
                }
            }
            return nodes;

        }

        static void greedy_capture(ref Node[] nodes)
        {
            foreach (var node in nodes)
            {
                if (!is_covered(nodes, node))
                {
                    node.captur = true;
                }
            }
        }
    }
}
