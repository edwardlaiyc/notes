import java.util.Scanner;
public class Strings
{
// --------------------------------------------
// Reads in an array of strings, sorts them,
// then prints them in sorted order.
// --------------------------------------------
public static void main (String[] args)
{
	String[] list;
	int size;
	Scanner scan = new Scanner(System.in);
	System.out.print ("\nHow many strings do you want to sort? ");
	size = scan.nextInt();
	list = new String[size];
	System.out.println ("\nEnter the strings...");
	for (int i = 0; i < size; i++)
		list[i] = scan.next();
		Sorting.insertionSort(list);
		System.out.println ("\nYour strings in sorted order...");
	for (int i = 0; i < size; i++)
		System.out.print(list[i] + " ");
	System.out.println ();
	}
}