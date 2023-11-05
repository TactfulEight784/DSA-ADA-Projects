import java.util.*;
import java.io.*;

public class hashlab2B {
    private RandomAccessFile file;
    private double loadFactor;
    private String probeMethod;
    private String hashMethod;

    public hashlab2B(double load, String probe, String hash) {
        this.loadFactor = load;
        this.probeMethod = probe;
        this.hashMethod = hash;
    }

    public void hash() {
        if (hashMethod.equals("Burris")) {
            if (probeMethod.equals("Linear")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (IOException e) {
                    System.out.println("test");
                }
            } else if (probeMethod.equals("Random")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (IOException e) {
                    System.out.println("test");
                }
            } else {
                System.out.println("Error wrong selection");
            }
        } else if (hashMethod.equals("MyHash")) {
            System.out.println("In My hash");
            if (probeMethod.equals("Linear")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (IOException e) {
                    System.out.println("test");
                }
            } else if (probeMethod.equals("Random")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (IOException e) {
                    System.out.println("test");
                }
                System.out.println("Random");
            } else {
                System.out.println("Error wrong selection");
            }
        }
    }

    public int burrisHash(String word) { // gives me my burris hash keys
        int key;
        double power = Math.pow(2, 16);
        key = Math.abs(
                (word.charAt(4) * 256 + word.charAt(1) + 317 + word.charAt(8)) / (int) power + word.charAt(5) - 10);
        return key;
    }

    public int myHash(String word) {
        int key = 0;
        long prime = 12582917;
        for (int i = 0; i < word.length(); i++) {
            key = (key * (int) prime + word.charAt(i)) % 128;
        }
        return key;
    }

    public void averageWhole(int[] array) {
        double average = 0;
        double sum = 0;
        int temp = 0;
        for (int i = 0; i < 127; i++) {
            sum = sum + array[i];
            if (array[i] != 0) {
                temp++;
            }
        }
        average = sum / temp;
        System.out.println(average);
    }

    public void firstminMaxAvgProbes(int[] array, int end) { // fix this so that it gets the correct
        // values for probes
        int max = -1, min = 800000000; // start and end variable to that we knwo where to start and stop
        int sum = 0;
        double average = 0;
        for (int i = end - 25; i < end; i++) {
            sum = sum + array[i];
            if (array[i] > max) {
                max = array[i];
            }
            if (array[i] < min) {
                min = array[i];
            }
        }
        average = sum / 25.0;
        System.out.println();
        System.out.println("Minimum probes is: " + min);
        System.out.println("Maximum probes is: " + max);
        System.out.println("Average probes is: " + average);
    }

    public void finalHash(double loadFact, String hashMethod, String probeMethod)
            throws IOException, IOException {
        RandomAccessFile file = new RandomAccessFile("output.txt", "rw");
        file.seek(file.length());

        Scanner scanner = new Scanner(new File("Words200D16.txt"));
        while (scanner.hasNextLine()) {
            String word = scanner.nextLine();
            int hash = 0;
            if (hashMethod.equals("Burris")) {
                hash = burrisHash(word);
            } else if (hashMethod.equals("MyHash")) {
                hash = myHash(word);
            }
            file.writeUTF(word + ": " + hash);
        }
        scanner.close();

        file.close();
    }

    public static void main(String[] args) {
        hashlab2B hashTable = new hashlab2B(.4, "Linear", "Burris");
        hashTable.hash();
    }
}