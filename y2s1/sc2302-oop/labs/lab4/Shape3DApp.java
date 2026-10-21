import java.util.Scanner;

// Total surface area of a 3D figure.
// Flow: enter count -> choose shape + dimensions for each -> choose calculation.
// Nothing is calculated until the user asks for it.
public class Shape3DApp
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
				System.out.println("  1) Sphere 2) Cuboid 3) Pyramid 4) Cone 5) Cylinder");
				int c = sc.nextInt();
				switch (c)
				{
					case 1: s = new Sphere(ask("radius: ")); break;
					case 2: { double l = ask("length: "); double b = ask("breadth: "); s = new Cuboid(l, b, ask("height: ")); break; }
					case 3: { double b = ask("base side: "); s = new Pyramid(b, ask("height: ")); break; }
					case 4: { double r = ask("radius: "); s = new Cone(r, ask("height: ")); break; }
					case 5: { double r = ask("radius: "); s = new Cylinder(r, ask("height: ")); break; }
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
