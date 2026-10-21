public class Cylinder extends Shape3D
{
	public Cylinder(double radius, double height)
	{
		faces = new Shape[] { new Circle(radius), new Circle(radius) };
		extra = 2 * Math.PI * radius * height;
	}
	public String getName() { return "Cylinder"; }
}
