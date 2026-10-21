// Common type for every figure. Calculations are done on request via area();
// a volume() can be added later (e.g. on a Shape3D subtype) without touching callers.
public abstract class Shape
{
	public abstract String getName();
	// 2D: area. 3D: total surface area.
	public abstract double area();
}
