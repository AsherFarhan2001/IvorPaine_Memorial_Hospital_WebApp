using Microsoft.AspNetCore.Mvc;
using System;
using System.Data.SqlClient;

namespace Hospital.Controllers
{
    public class UserController : Controller
    {
        public IActionResult Index()
        {
            return View("DashBoard");
        }
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string username, string password, string remember)
        {
 
            if (username == null || password == null)
            {
                return View();
            }

            else
            {
                Console.WriteLine("hhh");
                string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True;";
                SqlConnection conn = new SqlConnection(connectionString);
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT * FROM users WHERE username = @username AND password = @password ";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
              
                SqlDataReader reader = cmd.ExecuteReader();

                Console.WriteLine("ffff");

                if (reader.Read())
                {

                    return View("DashBoard");
                }

                else
                {

                    Console.WriteLine("hello");
                    return View();
                }
            }

        }

        public IActionResult Input()
        {
            return View();
        }

    
    }

    
}
