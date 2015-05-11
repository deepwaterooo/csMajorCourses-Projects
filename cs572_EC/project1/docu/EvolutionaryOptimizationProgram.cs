using System;
namespace EvolutionaryOptimization
{
  class EvolutionaryOptimizationProgram
  {
    static void Main(string[] args)
    {
      try
      {
        Console.WriteLine("\nBegin Evolutionary Optimization demo\n");
        Console.WriteLine("Goal is to find the (x,y) that minimizes Schwefel's function");
        Console.WriteLine("f(x,y) = (-x * sin(sqrt(abs(x)))) + (-y * sin(sqrt(abs(y))))");
        Console.WriteLine("Known solution is x = y = 420.9687 when f = -837.9658");
        
        int popSize = 100;
        int numGenes = 2;
        double minGene = -500.0;
        double maxGene = 500.0;
        double mutateRate = 1.0 / numGenes;    
        double precision = 0.0001;             // controls mutation magnitude
        double tau = 0.40;                     // tournament selection factor
        int maxGeneration = 8000;

        Console.WriteLine("\nPopulation size = " + popSize);
        Console.WriteLine("Number genes = " + numGenes);
        Console.WriteLine("minGene value = " + minGene.ToString("F1"));
        Console.WriteLine("maxGene value = " + maxGene.ToString("F1"));
        Console.WriteLine("Mutation rate = " + mutateRate.ToString("F4"));
        Console.WriteLine("Mutation precision = " + precision.ToString("F4"));
        Console.WriteLine("Selection pressure tau = " + tau.ToString("F2"));
        Console.WriteLine("Maximum generations = " + maxGeneration);

        // assumes existence of a Problem.Fitness method
        Evolver ev = new Evolver(popSize, numGenes, minGene, maxGene, mutateRate, precision, tau, maxGeneration); 
        double[] best = ev.Evolve();

        Console.WriteLine("\nBest (x,y) solution found:");
        for (int i = 0; i < best.Length; ++i)
          Console.Write(best[i].ToString("F4") + " ");

        double fitness = Problem.Fitness(best);
        Console.WriteLine("\nFunction value at best solution = " + fitness.ToString("F4"));

        Console.WriteLine("\nEnd Evolutionary Optimization demo\n");
        Console.ReadLine();
      }
      catch (Exception ex)
      {
        Console.WriteLine("Fatal: " + ex.Message);
        Console.ReadLine();
      }
    }
  } 

  public class Evolver
  {
    private int popSize;
    private Individual[] population;

    private int numGenes;
    private double minGene;
    private double maxGene;
    private double mutateRate;  // used by Mutate
    private double precision;   // used by Mutate

    private double tau;         // used by Select
    private int[] indexes;      // used by Select
    
    private int maxGeneration; 
    private static Random rnd = null;

    public Evolver(int popSize, int numGenes, double minGene, double maxGene, double mutateRate, double precision, double tau, int maxGeneration)
    {
      this.popSize = popSize;
      this.population = new Individual[popSize];
      for (int i = 0; i < population.Length; ++i)
        population[i] = new Individual(numGenes, minGene, maxGene, mutateRate, precision);

      this.numGenes = numGenes;
      this.minGene = minGene;
      this.maxGene = maxGene;
      this.mutateRate = mutateRate;
      this.precision = precision;
      this.tau = tau;

      this.indexes = new int[popSize];
      for (int i = 0; i < indexes.Length; ++i)
        this.indexes[i] = i;
      this.maxGeneration = maxGeneration;
      rnd = new Random(0);
    }

    public double[] Evolve()
    {
      double bestFitness = this.population[0].fitness;
      double[] bestChomosome = new double[numGenes];
      population[0].chromosome.CopyTo(bestChomosome, 0);
      int gen = 0;
      while (gen < maxGeneration)  {
        Individual[] parents = Select(2);
        Individual[] children = Reproduce(parents[0], parents[1]); // crossover & mutation
        Accept(children[0], children[1]);
        Immigrate();

        for (int i = popSize - 3; i < popSize; ++i)  {
          if (population[i].fitness < bestFitness)  {
            bestFitness = population[i].fitness;
            population[i].chromosome.CopyTo(bestChomosome, 0);
          }
        }
        ++gen;
      }
      return bestChomosome;
    } 

    private Individual[] Select(int n) // select n 'good' Individuals
    {
      //if (n > popSize)
      //  throw new Exception("xxxx");

      int tournSize = (int)(tau * popSize);
      if (tournSize < n) tournSize = n;
      Individual[] candidates = new Individual[tournSize];

      ShuffleIndexes();
      for (int i = 0; i < tournSize; ++i)
        candidates[i] = population[indexes[i]];
      Array.Sort(candidates);

      Individual[] results = new Individual[n];
      for (int i = 0; i < n; ++i)
        results[i] = candidates[i];

      return results;
    }

    private void ShuffleIndexes()
    {
      for (int i = 0; i < this.indexes.Length; ++i)
      {
        int r = rnd.Next(i, indexes.Length);
        int tmp = indexes[r]; indexes[r] = indexes[i]; indexes[i] = tmp;
      }
    }

    //public override string ToString()
    //{
    //  string s = "";
    //  for (int i = 0; i < this.population.Length; ++i)
    //    s += i + ": " + this.population[i].ToString() + Environment.NewLine;
    //  return s;
    //}

    private Individual[] Reproduce(Individual parent1, Individual parent2) // crossover and mutation
    {
      int cross = rnd.Next(0, numGenes - 1); // crossover point. 0 means 'between 0 and 1'.

      Individual child1 = new Individual(numGenes, minGene, maxGene, mutateRate, precision); // random chromosome
      Individual child2 = new Individual(numGenes, minGene, maxGene, mutateRate, precision); 

      for (int i = 0; i <= cross; ++i)
        child1.chromosome[i] = parent1.chromosome[i];
      for (int i = cross + 1; i < numGenes; ++i)
        child2.chromosome[i] = parent1.chromosome[i];
      for (int i = 0; i <= cross; ++i)
        child2.chromosome[i] = parent2.chromosome[i];
      for (int i = cross + 1; i < numGenes; ++i)
        child1.chromosome[i] = parent2.chromosome[i];

      child1.Mutate();
      child2.Mutate();

      child1.fitness = Problem.Fitness(child1.chromosome);
      child2.fitness = Problem.Fitness(child2.chromosome);

      Individual[] result = new Individual[2];
      result[0] = child1;
      result[1] = child2;

      return result;
    } // Reproduce

    private void Accept(Individual child1, Individual child2)
    {
      // place child1 and chil2 into the population, replacing two worst individuals
      Array.Sort(this.population);
      population[popSize - 1] = child1;
      population[popSize - 2] = child2;
      return;
    }

    private void Immigrate()
    {
      Individual immigrant = new Individual(numGenes, minGene, maxGene, mutateRate, precision);
      population[popSize - 3] = immigrant; // replace third worst individual
    }

  } // class Evolver

  // ------------------------------------------------------------------------------------------------

  public class Individual : IComparable<Individual>
  {
    public double[] chromosome;
    public double fitness; // smaller values are better for minimization

    private int numGenes;
    private double minGene;
    private double maxGene;
    private double mutateRate;
    private double precision;

    static Random rnd = new Random(0);

    public Individual(int numGenes, double minGene, double maxGene, double mutateRate, double precision)
    {
      this.numGenes = numGenes;
      this.minGene = minGene;
      this.maxGene = maxGene;
      this.mutateRate = mutateRate;
      this.precision = precision;
      this.chromosome = new double[numGenes];
      for (int i = 0; i < this.chromosome.Length; ++i)
        this.chromosome[i] = (maxGene - minGene) * rnd.NextDouble() + minGene;
      this.fitness = Problem.Fitness(chromosome);
    }

    public void Mutate()
    {
      double hi = precision * maxGene;
      double lo = -hi;
      for (int i = 0; i < chromosome.Length; ++i)
      {
        if (rnd.NextDouble() < mutateRate)
          chromosome[i] += (hi - lo) * rnd.NextDouble() + lo;
      }
    }

    //public override string ToString()
    //{
    //  string s = "";
    //  for (int i = 0; i < chromosome.Length; ++i)
    //    s += chromosome[i].ToString("F2") + " ";
    //  if (this.fitness == double.MaxValue)
    //    s += "| fitness = maxValue";
    //  else
    //    s += "| fitness = " + this.fitness.ToString("F4");
    //  return s;
    //}

    public int CompareTo(Individual other) // from smallest fitness (better) to largest
    {
      if (this.fitness < other.fitness) return -1;
      else if (this.fitness > other.fitness) return 1;
      else return 0;
    }

  } // class Individual

  
  public class Problem
  {
    public static double Fitness(double[] chromosome) // the 'cost' function we are trying to minimize
    {
      // Schwefel's function.
      // for n=2, solution is x = y = 420.9687 when f(x,y) = -837.9658
      double result = 0.0;
      for (int i = 0; i < chromosome.Length; ++i)
        result += (-1.0 * chromosome[i]) * Math.Sin(Math.Sqrt(Math.Abs(chromosome[i])));
      return result;
    }
  }

  //public class Helpers
  //{
  //  public static void ShowVector(double[] vector)
  //  {
  //    for (int i = 0; i < vector.Length; ++i)
  //      Console.Write(vector[i].ToString("F4") + " ");
  //    Console.WriteLine("");
  //  }
  //  public static void ShowVector(int[] vector)
  //  {
  //    for (int i = 0; i < vector.Length; ++i)
  //      Console.Write(vector[i] + " ");
  //    Console.WriteLine("");
  //  }
  //}

} // ns
