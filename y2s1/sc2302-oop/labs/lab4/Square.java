public class Square extends Shape
{
	private double side;
	public Square(double side) { this.side = side; }
	public String getName() { return "Square"; }
	public double area() { return side * side; }
}
