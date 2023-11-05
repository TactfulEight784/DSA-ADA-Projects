import java.util.*;
import java.io.*;

public class hashlab2 {
    private String[] hash = new String[128];
    private double loadFactor;
    private String probeMethod;
    private String hashMethod;

    public hashlab2(double load, String probe, String hash) {
        this.loadFactor = load;
        this.probeMethod = probe;
        this.hashMethod = hash;
    }

    public void hash() {
        if (hashMethod.equals("Burris")) {
            if (probeMethod.equals("Linear")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (FileNotFoundException e) {
                    System.out.println("test");
                }
            } else if (probeMethod.equals("Random")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (FileNotFoundException e) {
                    System.out.println("test");
                }
            } else {
                System.out.println("Error wrong selection");
            }
        } else if (hashMethod.equals("MyHash")) {
            if (probeMethod.equals("Linear")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (FileNotFoundException e) {
                    System.out.println("test");
                }
            } else if (probeMethod.equals("Random")) {
                try {
                    finalHash(loadFactor, hashMethod, probeMethod);
                } catch (FileNotFoundException e) {
                    System.out.println("test");
                }
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

    public int genRandom(int t) {
        int temp = (int) Math.pow(2, 9);
        int r = 1;
        int q = 0;
        int p = 0;
        while (p != t) {
            r = r * 5;
            r = r % temp;
            q = r / 4;
            p++;
        }
        return q;
    }

    public void display(int[] array) {
        String str;
        int key = 0;
        int probes;
        System.out.println(
                "Index                  " + "    Word                " + " Probes"
                        + "                  Original Hash");
        for (int i = 0; i < 16; i++) {
            for (int j = i * 8; j < 8 * (i + 1); j++) {
                probes = array[j];
                if (hash[j] == null) {
                    str = "empty           ";
                    key = -1;
                } else {
                    str = hash[j];
                    if (hashMethod.equals("Burris")) {
                        key = burrisHash(str);
                    } else if (hashMethod.equals("MyHash")) {
                        key = myHash(str);
                    }
                }
                System.out
                        .println(String.format("%-15s", String.valueOf(j)) + "|        " + String.format("%-15s", str)
                                + " |       "
                                + String.format("%-15s", String.valueOf(probes))
                                + "|            " + String.format("%-15s", String.valueOf(key)));
                // put index word key how many probes

            }
        }
    }

    public void finalHash(double loadFact, String hashMethod, String probeMethod) throws FileNotFoundException {
        int[] probes = new int[128];
        int[] realprobes = new int[128];
        double end = loadFact * 128;
        System.out.println("\nfinalHash" + " " + hashMethod + " " + probeMethod);
        File file = new File("C:/Users/dylan/Documents/code/java/DSAHash/Words200D16.txt");
        Scanner scanner = new Scanner(file);
        while (scanner.hasNext()) {
            for (int i = 0; i <= 127 * loadFact; i++) {
                String line = scanner.nextLine();
                int maxprobes = 1;
                if (hashMethod.equals("Burris")) {
                    int key = burrisHash(line);
                    if (probeMethod.equals("Linear")) {
                        while (hash[key] != null) {
                            key = key + 1;
                            maxprobes = maxprobes + 1;
                            if (key == 128) {
                                key = 0;
                            }
                        }
                        realprobes[key] = maxprobes;
                        probes[i] = maxprobes;
                        hash[key] = line;
                        // System.out.println(line + " " + key + " " + i + " " + maxprobes);
                    } else if (probeMethod.equals("Random")) {
                        int temp = key;
                        while (hash[temp] != null) {
                            temp = (genRandom(maxprobes) + key) % 128;
                            maxprobes = maxprobes + 1;
                        }
                        realprobes[temp] = maxprobes;
                        probes[i] = maxprobes;
                        hash[temp] = line; // write
                    }
                } else if (hashMethod.equals("MyHash")) {
                    int key = myHash(line);
                    if (probeMethod.equals("Linear")) {
                        while (hash[key] != null) {
                            key = key + 1;
                            maxprobes = maxprobes + 1;
                            if (key == 128) {
                                key = 0;
                            }
                        }
                        realprobes[key] = maxprobes;
                        probes[i] = maxprobes;
                        hash[key] = line; // file
                        // System.out.println(line + " " + key + " " + i + " " + maxprobes);
                    } else if (probeMethod.equals("Random")) {
                        int temp = key;
                        while (hash[temp] != null) {
                            temp = (genRandom(maxprobes) + key) % 128;
                            maxprobes = maxprobes + 1;
                        }
                        realprobes[temp] = maxprobes;
                        probes[i] = maxprobes;
                        hash[temp] = line; // file
                    }
                }
            }
            display(realprobes);
            System.out.print("\n\nFirst 25 keys:");
            firstminMaxAvgProbes(probes, 25);
            System.out.print("\n\nLast 25 keys:");
            firstminMaxAvgProbes(probes, (int) end);
            System.out.print("\n\nTotal Average:");
            averageWhole(probes);
            System.out.println("\n\nTheoretical Probes:");
            theoretical();
            break;
        }
        scanner.close();

    }

    public void theoretical() {
        double theo = 1 - (loadFactor / 2);
        theo = theo / (1 - loadFactor);
        System.out.println("Theoretical Probes: " + theo);
    }

    public static void main(String[] args) {
        hashlab2 Mylin40 = new hashlab2(.4, "Linear", "MyHash");
        hashlab2 Mylin80 = new hashlab2(.8, "Linear", "MyHash");
        hashlab2 Myrand40 = new hashlab2(.4, "Random", "MyHash");
        hashlab2 Myrand80 = new hashlab2(.8, "Random", "MyHash");
        hashlab2 Brand40 = new hashlab2(.4, "Random", "Burris");
        hashlab2 Blin40 = new hashlab2(.4, "Linear", "Burris");
        hashlab2 Brand80 = new hashlab2(.8, "Random", "Burris");
        hashlab2 Blin80 = new hashlab2(.8, "Linear", "Burris");
        Blin40.hash();
        Brand40.hash();
        Brand80.hash();
        Blin80.hash();
        Mylin40.hash();
        Mylin80.hash();
        Myrand40.hash();
        Myrand80.hash();

    }
}