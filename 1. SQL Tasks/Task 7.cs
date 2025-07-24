//Assignment: Object-Oriented Programming with a Student Class

// Create a Student Class
public class Student
{
    // a. Properties: Name, Age, and Grade.
    public string Name;
    public int Age;
    public string Grade;

    public Student(string name, int age, string grade)
    {
        Name = name;
        Age = age;
        Grade = grade;
    }

    // b. A method DisplayInfo() that prints the student's details.
    public void DisplayInfo()
    {
        Console.Write(@$"Student Details:
                    Name: {Name}
                    Age: {Age}
                    Grade: {Grade}");

        Console.Write("\n=====================================\n");
    }   
}

public class Program
{
    public static void Main()
    {
        // a. Create two student objects.
        var student1 =  new Student("Ahmed", 20, "A+");
        var student2 =  new Student("Bob", 22, "B+");

        // b. Call the DisplayInfo() method for each object to print their details.
        student1.DisplayInfo();
        student2.DisplayInfo();
    }
}
