// A 3D solid HAS 2D faces (composition), it is not a kind of 2D shape:
// a Cylinder is not a Circle, but it has two Circle ends.
// Surface area = sum of the areas of its parts.
public abstract class Shape3D extends Shape
{
	protected Shape[] faces;
	protected double extra; // curved surface that has no 2D Shape equivalent

	public double area()
	{
		double total = extra;
		for (Shape f : faces)
			total += f.area();
		return total;
	}
}
