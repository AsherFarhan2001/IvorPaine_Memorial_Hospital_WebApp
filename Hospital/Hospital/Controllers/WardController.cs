using Hospital.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Dynamic;
using System.IO;

namespace Hospital.Controllers
{
	public class WardController : Controller
	{
		public IActionResult Index()
		{
			return View("Ward");
		}

		public IActionResult WardInfo(string wardID, string wardName)
		{
			if(wardName == null)
			{
                Console.WriteLine("Records Using Ward ID");

				List<Patient_History> history = new List<Patient_History>();
				List<Wardcs> ward = new List<Wardcs>();

                dynamic mymodel = new ExpandoObject();

                string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
                SqlConnection conn = new SqlConnection(connectionString);
                SqlConnection conn1 = new SqlConnection(connectionString);
                SqlConnection conn2 = new SqlConnection(connectionString);

                conn.Open();
                conn1.Open();
				conn2.Open();

                SqlCommand cmd = conn.CreateCommand();
                SqlCommand cmd1 = conn1.CreateCommand();
                SqlCommand cmd2 = conn2.CreateCommand();

				cmd.CommandText = "select c.Pat_id,g.name,b.name careUnit , a.bedno,f.name const_name,a.admit_date from cu_admit a,careunit b,pataint_Incharge c,team d,DocTeam_rec e,consultant f,patient g where a.cu_code=b.Cu_code and b.Ward_id=@ID and a.pat_id=c.pat_id and c.Doc_id=e.DOc_Id and e.team_code=d.team_code and d.const_id=f.const_id and c.pat_id=g.pat_id;";
				cmd1.CommandText = "select w.ward_id, i.sis_id, i.shift, w.name Ward_name, s.name Spec_name from NurseShift i, ward w, Speciality s where i.incharge_ward = @ID and w.ward_id = @ID and w.spec_code = s.spec_code;";
				cmd2.CommandText = "select count(*) total from NursePreHistory where ward_id = @ID;";

                cmd.Parameters.AddWithValue("@ID", wardID);
                cmd1.Parameters.AddWithValue("@ID", wardID);
				cmd2.Parameters.AddWithValue("@ID", wardID);

                SqlDataReader reader = cmd.ExecuteReader();
                SqlDataReader reader1 = cmd1.ExecuteReader();
				SqlDataReader reader2 = cmd2.ExecuteReader();

				Wardcs wards = new Wardcs();
				Patient_History p_history = new Patient_History();

				string patId = "";
				string patname = "";
				string careunit = "";
				string bedno = "";
				string consultant = "";
				string admit = "";
				string wardId = "";
				string nurseId = "";
				string shift = "";
				string wardname = "";
				string spec = "";
				string nonreg = "";

				if (reader.Read())
				{
					patId = reader["Pat_id"].ToString();
					patname = reader["name"].ToString();
					careunit = reader["careUnit"].ToString();
					bedno = reader["bedno"].ToString();
					consultant = reader["const_name"].ToString();
					admit = reader["admit_date"].ToString();

					p_history.patientID = patId;
					p_history.patientName = patname;
					p_history.careunit = careunit;
					p_history.bedNo = bedno;
					p_history.consultant = consultant;
					p_history.admitDate = admit;

					history.Add(p_history);

					mymodel.patientHistory = history;
				}

				conn.Close();

				if(reader2.Read())
				{
					nonreg = reader2["total"].ToString();
					wards.nonRegNurses = nonreg;
				}

				conn2.Close();

				if(reader1.Read())
				{
					wardId = reader1["ward_id"].ToString();
					nurseId = reader1["sis_id"].ToString();
					shift = reader1["shift"].ToString();
					wardname = reader1["ward_name"].ToString();
					spec = reader1["Spec_name"].ToString();

					wards.wardID = wardId;
					wards.nurseID = nurseId;
					wards.shift = shift;
					wards.wardName = wardname;
					wards.speciality = spec;

					ward.Add(wards);

					mymodel.Ward = ward;

				}

				conn1.Close();

				return View(mymodel);

            }

			else
			{
                Console.WriteLine("Records Using Ward ID");
            }
					
			return View();
		}
	}
}
