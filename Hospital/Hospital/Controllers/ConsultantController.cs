using Hospital.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;

namespace Hospital.Controllers
{
    public class ConsultantController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ConsultantInput()
        {
            return View("ConsultantInput");
        }

        public IActionResult AddConsultant(string consultantID, string consultantName, string address, int billing, int salary, string phone, string dob, string spec, string position)
        {
            string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True;";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "Insert into Consultant VALUES (@ID, @name, @address, @billingrate, @salary, @phone, @dob, @specs, @position)";
            cmd.Parameters.AddWithValue("@ID", consultantID);
            cmd.Parameters.AddWithValue("@name", consultantName);
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@billingrate", billing);
            cmd.Parameters.AddWithValue("@salary", salary);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@dob", dob);
            cmd.Parameters.AddWithValue("@specs", spec);
            cmd.Parameters.AddWithValue("@position", position);

            var res = cmd.ExecuteNonQuery();

            return View("ConsultantInput");
        }
    }
}
