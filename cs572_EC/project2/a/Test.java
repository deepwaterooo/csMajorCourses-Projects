public class Test {
    public double X;

    public static void main(String [] args){
        Individual i = new Individual();
        i.generate(2);
        i.evaluate_print();
        i.calc_size();
        System.out.println("Size = " + i.get_size());
    }
}
