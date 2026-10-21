// Square-based pyramid: 1 square base + 4 triangular sides.
public class Pyramid extends Shape3D
{
	public Pyramid(double baseSide, double height)
	{
		double slant = Math.sqrt(height * height + (baseSide / 2) * (baseSide / 2));
		faces = new Shape[] {
			new Square(baseSide),
			new Triangle(baseSide, slant), new Triangle(baseSide, slant),
			new Triangle(baseSide, slant), new Triangle(baseSide, slant)
		};
	}
	public String getName() { return "Pyramid"; }
}
