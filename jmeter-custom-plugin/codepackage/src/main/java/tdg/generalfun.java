package tdg;

import java.util.Random;

public class generalfun {
    /**
     * Return Int Random Number
     * @return
     */
    public static int generate_int_randomnumber()
    {
        Random random = new Random();  
        return random.nextInt();
    }

    /**
     * Return Alphabet random Number
     * @return
     */
    public static String generate_alphabet_randomnumber() {
        Random rnd = new Random();
        String randomAlphabet = "" + (char) ('A' + rnd.nextInt(26));
        return randomAlphabet;
    }

}
