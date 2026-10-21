public class Sphere extends Shape3D
{
	public Sphere(double radius)
	{
		faces = new Shape[0];
		extra = 4 * Math.PI * radius * radius;
	}
	public String getName() { return "Sphere"; }
}
