import java.lang.*;

public class Individual {
	public int size;       // total number of nodes in the tree
	public int terms;      // total number of terminals in the tree
	public int non_terms;  // total number of non-terminals in the tree
    public Node the_indiv;
    public final int NUM_POINTS = 5; // test points
    public float fitness;
        
    public float [] inputs = {1,2,3,4,5};
    public float [] outputs = {1,4,9,16,25};

    public void erase(){
        the_indiv.erase();
    }

    public void generate(int max_depth){
        the_indiv = new Node();
        the_indiv.full(0,max_depth,null);
    }

    public void calc_size(){
        terms = 0;
        non_terms = 0;
        size = 0;			
        the_indiv.calc_size(terms,non_terms);
        size += (terms + non_terms);
    }

    public void evaluate(){  
        fitness = 0;
        float output;
        for(int j=0; j < NUM_POINTS; j++){
            output = the_indiv.evaluate(inputs[j]);
            fitness += (Math.pow((output-outputs[j]),2));
        }
        fitness = (float)Math.sqrt(fitness);
    }

    public void evaluate_print(){
        fitness = 0;
        float output;
        for(int j=0; j < NUM_POINTS; j++){
            output = the_indiv.evaluate(inputs[j]);
            fitness += (Math.pow((outputs[j]-output),2));
            System.out.println(inputs[j] + ",\t" + output + ",\t" + outputs[j] + " , ");
        }
        fitness = (float)Math.sqrt(fitness); // square root of the sum of the squared errors
            System.out.println("Fitness = " + fitness);
    }

    public float get_fitness() 
    {
        return fitness;
    }

    public float get_size() 
    {
        return size;
    }
}
