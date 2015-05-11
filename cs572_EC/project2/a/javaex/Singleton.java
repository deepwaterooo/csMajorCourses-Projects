class Singleton {
    public static Singleton singleton = new Singleton(); // the order matters
    public static int a;
    public static int b = 0;
    
    private Singleton() {
        super();
        a++;
        b++; 
    } 

    public static Singleton GetInstence() {
        return singleton;
    } 
}
