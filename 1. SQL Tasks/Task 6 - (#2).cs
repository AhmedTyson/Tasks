
static void Main()
        {
            /*      3. Take 3 numbers from the user.
            •   Output: maximum number and minimum number*/

            Console.WriteLine("Please Enter 3 numbers:");
            Console.WriteLine("Please insert Num1:");
            int num1 = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Please insert Num2:");
            int num2 = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Please insert Num3:");
            int num3 = Convert.ToInt32(Console.ReadLine());

            int max, min;
            if (num1 >= num2 && num1 >= num3)
            {
                max = num1;
            }

            else if (num2 >= num1 && num2 >= num3)
            {
                max = num2;
            }
            else
            {
                max = num3;
            }


            if (num1 <= num2 && num1 <= num3)
            {
                min = num1;
            }
            else if (num2 <= num1 && num2 <= num3)
            {
                min = num2;
            }
            else
            {
                min = num3;
            }


            if (num1 == num2 && num2 == num3)
            {
                Console.WriteLine("The 3 numbers are equal");
            }
            else
            {
                Console.WriteLine("Max number is: " + max);
                Console.WriteLine("Min number is: " + min);
            }


            Console.ReadKey();
        }

