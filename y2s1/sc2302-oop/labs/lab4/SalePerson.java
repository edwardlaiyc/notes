// Represents a sales person: name and total sales for the week.
public class SalePerson implements Comparable<SalePerson>
{
	private String firstName;
	private String lastName;
	private int totalSales;

	public SalePerson(String firstName, String lastName, int totalSales)
	{
		this.firstName = firstName;
		this.lastName = lastName;
		this.totalSales = totalSales;
	}

	public String getFirstName() { return firstName; }
	public String getLastName() { return lastName; }
	public int getTotalSales() { return totalSales; }

	// <lastName> , <firstName> : <totalSales>
	public String toString()
	{
		return lastName + " , " + firstName + " : " + totalSales;
	}

	// Two sales people are equal if first and last names match.
	public boolean equals(Object other)
	{
		if (this == other) return true;
		if (!(other instanceof SalePerson)) return false;
		SalePerson p = (SalePerson) other;
		return firstName.equals(p.firstName) && lastName.equals(p.lastName);
	}

	public int hashCode()
	{
		return firstName.hashCode() * 31 + lastName.hashCode();
	}

	// Negative if this has fewer sales, positive if more.
	// Ties are broken by last name. Sorting.insertionSort is DESCENDING, so
	// the name comparison is reversed here: that makes tied people come out
	// in ascending alphabetical order of last name, as the lab requires.
	public int compareTo(SalePerson other)
	{
		if (totalSales != other.totalSales)
			return totalSales < other.totalSales ? -1 : 1;
		return other.lastName.compareTo(lastName);
	}
}
