import java.util.Scanner;

// Total area of a 2D figure.
// Flow: enter count -> choose shape + dimensions for each -> choose calculation.
// Nothing is calculated until the user asks for it.
public class Shape2DApp
{
	static Scanner sc = new Scanner(System.in);

	static double ask(String prompt)
	{
		System.out.print(prompt);
		return sc.nextDouble();
	}

	public static void main(String[] args)
	{
		System.out.print("Total number of shapes: ");
		int n = sc.nextInt();
		Shape[] shapes = new Shape[n];

		for (int i = 0; i < n; i++)
		{
			Shape s = null;
			while (s == null)
			{
				System.out.println("Shape " + (i + 1) + ":");
				System.out.println("  1) Square 2) Rectangle 3) Circle 4) Triangle");
				int c = sc.nextInt();
				switch (c)
				{
					case 1: s = new Square(ask("side: ")); break;
					case 2: { double l = ask("length: "); s = new Rectangle(l, ask("breadth: ")); break; }
					case 3: s = new Circle(ask("radius: ")); break;
					case 4: { double b = ask("base: "); s = new Triangle(b, ask("height: ")); break; }
					default: System.out.println("Invalid choice.");
				}
			}
			shapes[i] = s;
		}

		System.out.println("Calculation: 1) Area");
		int calc = sc.nextInt();
		if (calc != 1)
		{
			System.out.println("Only Area is supported for now.");
			return;
		}

		double total = 0;
		for (Shape s : shapes) // polymorphic call
		{
			double a = s.area();
			System.out.printf("%s: %.2f%n", s.getName(), a);
			total += a;
		}
		System.out.printf("Total: %.2f%n", total);
	}
}
