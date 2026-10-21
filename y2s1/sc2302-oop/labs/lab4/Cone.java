public class Cone extends Shape3D
{
	public Cone(double radius, double height)
	{
		double slant = Math.sqrt(radius * radius + height * height);
		faces = new Shape[] { new Circle(radius) };
		extra = Math.PI * radius * slant;
	}
	public String getName() { return "Cone"; }
}
