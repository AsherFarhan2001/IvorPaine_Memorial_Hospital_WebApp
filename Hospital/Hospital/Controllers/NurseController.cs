using Hospital.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Dynamic;

namespace Hospital.Controllers
{
	public class NurseController : Controller
	{
		public IActionResult Index()
		{
			return View("NurseDetails");
		}

		public IActionResult NonRegisterNurseInfo()
		{
			List<NonRegisterNurse> nonRegisterNurse = new List<NonRegisterNurse>();

            string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
            SqlConnection conn = new SqlConnection(connectionString);

			conn.Open();

            SqlCommand cmd = conn.CreateCommand();

			cmd.CommandText = "select * from nurse a,nonregnurse b  where a.nurse_id=b.nrnurse_id;";

            SqlDataReader reader = cmd.ExecuteReader();

            string nurseid  = "";
            string nursename = "";
            string address = "";
            string telephone = "";
            string dob = "";
            string hiredate = "";
            string position = "";
            string rate= "";
            string workinghour = "";

            dynamic mymodel = new ExpandoObject();

           // NonRegisterNurse nonreg = new NonRegisterNurse();

            while (reader.Read())
            {
                nurseid = reader["nurse_ID"].ToString();
                nursename = reader["name"].ToString();
                address = reader["address"].ToString();
                telephone = reader["telno"].ToString();
                dob = reader["dob"].ToString();
                hiredate = reader["hireDate"].ToString();
                position = reader["position"].ToString();
                rate = reader["rate"].ToString();
                workinghour = reader["workHrs"].ToString();

                NonRegisterNurse nonreg = new NonRegisterNurse();

                nonreg.nurseID = nurseid;
                nonreg.nurseName = nursename;
                nonreg.address = address;
                nonreg.phone = telephone;
                nonreg.dob = dob;
                nonreg.hiredate = hiredate;
                nonreg.position = position;
                nonreg.rate = rate;
                nonreg.workingHours = workinghour;


                nonRegisterNurse.Add(nonreg);

                mymodel.NonReg = nonRegisterNurse;



               

            }

            return View(mymodel);
            return View();

            conn.Close();
		}

        public IActionResult SisterInfo()
        {
            List<Sister> sister = new List<Sister>();

            string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
            SqlConnection conn = new SqlConnection(connectionString);

            conn.Open();

            SqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "select * from nurse a,nurseshift b  where a.nurse_id=b.sis_id";

            SqlDataReader reader = cmd.ExecuteReader();

            string nurseid = "";
            string nursename = "";
            string address = "";
            string telephone = "";
            string dob = "";
            string hiredate = "";
            string position = "";
            string shift = "";
            string inchargeward = "";

            dynamic mymodel = new ExpandoObject();

    

            while (reader.Read())
            {
                nurseid = reader["nurse_ID"].ToString();
                nursename = reader["name"].ToString();
                address = reader["address"].ToString();
                telephone = reader["telno"].ToString();
                dob = reader["dob"].ToString();
                hiredate = reader["hireDate"].ToString();
                position = reader["position"].ToString();
                shift = reader["shift"].ToString();
                inchargeward = reader["incharge_ward"].ToString();

                Sister sisters = new Sister();

                sisters.nurseID = nurseid;
                sisters.nurseName = nursename;
                sisters.address = address;
                sisters.phone = telephone;
                sisters.dob = dob;
                sisters.hiredate = hiredate;
                sisters.position = position;
                sisters.shift = shift;
                sisters.inchargeward = inchargeward;


                sister.Add(sisters);

                mymodel.Sist = sister;





            }

            return View(mymodel);
            return View();

            conn.Close();
        }
    }
}
