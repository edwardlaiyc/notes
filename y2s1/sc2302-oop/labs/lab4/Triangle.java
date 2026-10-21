public class Triangle extends Shape
{
	private double base, height;
	public Triangle(double base, double height) { this.base = base; this.height = height; }
	public String getName() { return "Triangle"; }
	public double area() { return 0.5 * base * height; }
}
