public class Cuboid extends Shape3D
{
	public Cuboid(double length, double breadth, double height)
	{
		faces = new Shape[] {
			new Rectangle(length, breadth), new Rectangle(length, breadth),
			new Rectangle(length, height),  new Rectangle(length, height),
			new Rectangle(breadth, height), new Rectangle(breadth, height)
		};
	}
	public String getName() { return "Cuboid"; }
}
