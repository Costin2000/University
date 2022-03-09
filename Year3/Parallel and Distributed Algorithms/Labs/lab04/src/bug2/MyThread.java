package bug2;

/**
 * Why does this code not block? We took the same lock twice!
 *
 * There is nothing to modify for this example. Just explain why we do NOT
 * have a deadlock.
 */

/**
 * Nu avem un deadlock pentru ca in Java odata ce am obtinut acces la monitorul
 * unui obiect putem intra pe toate metodele/blocurile sincronizate cu acel obiect.
 */
public class MyThread implements Runnable {
    static int i;

    @Override
    public void run() {
        synchronized (this) {
            synchronized (this) {
                i++;
            }
        }
    }
}
