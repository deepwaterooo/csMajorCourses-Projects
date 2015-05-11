import java.util.Random;
import java.lang.Enum;
 
public class Node {
    final int NUM_NON_TERMS = 2;
    final int NUM_TERMS = 2;
    final int TOTAL_OPS = 4  ;
    final int MAX_ARITY = 4;

    public static final int add = 0;
    public static final int subtract = 1;
    public static final int inputX = 2;
    public static final int constt = 3;
    
    public static int p = 4;
    private Node parent;
    public float val;
    public Node [] branches;
    final float CONST_LIMIT = 10.0f;
	public int type;               // stores the terminal or non-terminal
	public float const_value;     // stores the constant, if any

    public Node() 
    {
        parent = null;
        //this.val = val;
        branches = new Node[p]; 
    }

    public Node clone(Node p){
        Node tmp = new Node();
        tmp.val = val;
        tmp.const_value = p.const_value;
        System.arraycopy(tmp.branches, 0, p.branches, 0, 4);
        return tmp;
    }

    public void copy(Node source){
        type = source.type;
        const_value = source.const_value;
        if(type < NUM_NON_TERMS){
            for(int i =0; i < MAX_ARITY; i++){
                if(source.branches[i] != null){		
                    branches[i] = new Node();
                    branches[i].copy(source.branches[i]);
                }
                else{
                    branches[i] = null;
                }
            }
        }
    }

    public void erase(){
        if(type < NUM_NON_TERMS){
            for(int i =0; i < MAX_ARITY; i++)
                if(branches[i] != null)
                    branches[i] = null;
        }
    }

    public void full(int depth, int max, Node p){  
        parent = p;       // point to parent node

        Random random = new Random();
        int intNumber = random.nextInt();

        if(depth >= max)  // if at max depth put in terminal
            type = NUM_NON_TERMS + intNumber % NUM_TERMS;
        else {            // else add non-terminal
            intNumber = random.nextInt();
            type = intNumber % NUM_NON_TERMS;
            System.out.println("type: " + type);
            
            switch (type){
            case add:	
                for(int i =0; i < 2; i++){
                    branches[i] = new Node();
                    branches[i].full(depth+1,max,this);
                }
                for(int i=2;i<MAX_ARITY;i++)  // initially make all branches null
                    branches[i] = null;
                break;	
            case subtract:	
                for(int i =0; i < 2; i++){
                    branches[i] = new Node();
                    branches[i].full(depth+1,max,this);
                }
                for(int i=2;i<MAX_ARITY;i++)  // initially make all branches null
                    branches[i] = null;
                break;	
            default:
                System.out.println("Unknown case in full");
            }
        }
        if(type == constt) {  // if a constant include a value
            intNumber = random.nextInt();
            const_value = (float)(intNumber*2.0*CONST_LIMIT - (CONST_LIMIT/2.0));
        }
    }

    public float evaluate(float X){
        public float l,r;
        switch(type){
		case add:      // +
			l=branches[0].evaluate(X);
			r=branches[1].evaluate(X);
			return(l+r);
		case subtract: // -
			l=branches[0].evaluate(X);
			r=branches[1].evaluate(X);
			return(l-r);
		case inputX:   // X
			return(X);
		case constt:
			return(const_value);
		default:
            System.out.println("Error, unknown instruction ");
            return -1;
        }
    }

    public void calc_size(int terms, int non_terms){  // passing by address here
        if(type >= NUM_NON_TERMS){	// count size
            terms++;
            system.out.println("terms: " + terms);
            
            return;
        }
        else{
            non_terms++;
            system.out.println("non_terms: " + non_terms);
            for(int i=0;i<MAX_ARITY;i++){
                if(branches[i] != null){
                    branches[i].calc_size(terms,non_terms);
                }
            }
        }
    }
}
