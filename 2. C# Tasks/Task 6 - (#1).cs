static void Main()
        {
            // 1- Take response from user for name and age
            Console.WriteLine("-- Welcome in our voting system --");

            Console.Write("Please enter your name: ");
            string name = Console.ReadLine();

            Console.Write("Please enter your age: ");
            int myAge = Convert.ToInt32(Console.ReadLine());

            // Output the welcome message
            Console.WriteLine($"Hi Mr. {name}. Your age is {myAge}");

            // 2- Check if the user is old enough to vote
            if (myAge >= 18)
            {
                Console.WriteLine("Old enough to vote!");
            }
            else
            {
                Console.WriteLine("Not old enough to vote.");
            }

            Console.ReadKey();
        }
