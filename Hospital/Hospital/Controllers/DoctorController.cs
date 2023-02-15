using Hospital.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Abstractions;
using System.Net;
using System.Numerics;
using Microsoft.Data.SqlClient;
using System.Dynamic;

namespace Hospital.Controllers
{
	public class DoctorController : Controller
	{
		public IActionResult Index()
		{
			return View("DoctorFind");
		}

		public IActionResult DoctorInput()
		{
			return View("DoctorInput");
		}
		public IActionResult DoctorInfo(string staffID, string staffName)
		{
			if (staffName == null)
			{
                Console.WriteLine("Records Using Ward ID");

				List<Doctor> doctor = new List<Doctor>();
				List<Experience> experience = new List<Experience>();

                dynamic mymodel = new ExpandoObject();

                string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
                SqlConnection conn = new SqlConnection(connectionString);
                SqlConnection conn1 = new SqlConnection(connectionString);

                conn.Open();
                conn1.Open();

                SqlCommand cmd = conn.CreateCommand();
                SqlCommand cmd1 = conn1.CreateCommand();

                cmd.CommandText = "select a.doc_id, a.name,a.positon,b.joindate from juniorDr a,docteam_rec b where a.doc_id=b.doc_id and a.doc_id=@ID";
                cmd1.CommandText = "select * from performance where doc_id = @ID";

                cmd.Parameters.AddWithValue("@ID", staffID);
                cmd1.Parameters.AddWithValue("@ID", staffID);

                SqlDataReader reader = cmd.ExecuteReader();
                SqlDataReader reader1 = cmd1.ExecuteReader();

                string docId = "";
                string docname = "";
                string position = "";
                string joindate = "";
                string fromdate = "";
                string todate = "";
                string p_position = "";
                string establishment = "";
                string grade = "";
                string perfomance = "";
               
                if(reader.Read())
                {
                    docId = reader["doc_id"].ToString();
                    docname = reader["name"].ToString();
                    position = reader["positon"].ToString();
                    joindate = reader["joindate"].ToString();

                    Doctor doctors = new Doctor();

                    doctors.DoctorID = docId;
                    doctors.DoctorName = docname;
                    doctors.DoctorPosition = position;
                    doctors.DateJoin = joindate;

                    doctor.Add(doctors);

                    mymodel.Doctor = doctor;
                }

                conn.Close();

                if (reader1.Read())
                {
                    fromdate = reader1["fromDate"].ToString();
                    todate = reader1["toDate"].ToString();
                    p_position = reader1["newPosition"].ToString();
                    establishment = reader1["estab"].ToString();
                    grade = reader1["date_grade"].ToString();
                    perfomance = reader1["perf_description"].ToString();

                    Experience experience1 = new Experience();

                    experience1.fromDate = fromdate;
                    experience1.toDate = todate;
                    experience1.position = p_position;
                    experience1.establishment = establishment;
                    experience1.dateGrade = grade;
                    experience1.perfomance = perfomance;

                    experience.Add(experience1);

                    mymodel.Experience = experience;

                }

                conn1.Close();

			    return View(mymodel);
            }

            else
            {
                List<Doctor> doctor = new List<Doctor>();
                List<Experience> experience = new List<Experience>();

                dynamic mymodel = new ExpandoObject();

                string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
                SqlConnection conn = new SqlConnection(connectionString);
                SqlConnection conn1 = new SqlConnection(connectionString);

                conn.Open();
                conn1.Open();

                SqlCommand cmd = conn.CreateCommand();
                SqlCommand cmd1 = conn1.CreateCommand();

                cmd.CommandText = "select a.doc_id, a.name,a.positon,b.joindate from juniorDr a,docteam_rec b where a.doc_id=b.doc_id and a.name= @name";
                cmd1.CommandText = "select SerPerf_NO, a.Doc_ID ,a.Team_Code ,a.DATE_GRADE , a.perf_description ,a.fromDate ,a.toDate ,a.estab ,a.newPosition from performance a,juniorDr b where b.name=@name and b.Doc_id=a.Doc_id;";

                cmd.Parameters.AddWithValue("@name", staffName);
                cmd1.Parameters.AddWithValue("@name", staffName);

                SqlDataReader reader = cmd.ExecuteReader();
                SqlDataReader reader1 = cmd1.ExecuteReader();

                string docId = "";
                string docname = "";
                string position = "";
                string joindate = "";
                string fromdate = "";
                string todate = "";
                string p_position = "";
                string establishment = "";
                string grade = "";
                string perfomance = "";

                if (reader.Read())
                {
                    docId = reader["doc_id"].ToString();
                    docname = reader["name"].ToString();
                    position = reader["positon"].ToString();
                    joindate = reader["joindate"].ToString();

                    Doctor doctors = new Doctor();

                    doctors.DoctorID = docId;
                    doctors.DoctorName = docname;
                    doctors.DoctorPosition = position;
                    doctors.DateJoin = joindate;

                    doctor.Add(doctors);

                    mymodel.Doctor = doctor;
                }

                conn.Close();

                if (reader1.Read())
                {
                    fromdate = reader1["fromDate"].ToString();
                    todate = reader1["toDate"].ToString();
                    p_position = reader1["newPosition"].ToString();
                    establishment = reader1["estab"].ToString();
                    grade = reader1["date_grade"].ToString();
                    perfomance = reader1["perf_description"].ToString();

                    Experience experience1 = new Experience();

                    experience1.fromDate = fromdate;
                    experience1.toDate = todate;
                    experience1.position = p_position;
                    experience1.establishment = establishment;
                    experience1.dateGrade = grade;
                    experience1.perfomance = perfomance;

                    experience.Add(experience1);

                    mymodel.Experience = experience;

                }

                conn1.Close();

                return View(mymodel);
            }
		}

		public IActionResult AddDoctor(string doctorID, string doctorName, string address, string salary, string phone, string position, string dob)
		{
            string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True;";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = conn.CreateCommand();

            cmd.CommandText = "Insert into juniorDR VALUES (@ID, @name, @address, @salary, @phone, @position, @dob)";
            cmd.Parameters.AddWithValue("@ID", doctorID);
            cmd.Parameters.AddWithValue("@name", doctorName);
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@salary", salary);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@position", position);
            cmd.Parameters.AddWithValue("@dob", dob);

            var res = cmd.ExecuteNonQuery();

            return View("DoctorInput");

        }
	}
}
