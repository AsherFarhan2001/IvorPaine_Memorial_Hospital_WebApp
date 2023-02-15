using Hospital.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Dynamic;

namespace Hospital.Controllers
{
	public class PatientController : Controller
	{
		public IActionResult Index()
		{
			return View("PatientFind");
		}

		public IActionResult PatientInput()
		{
			return View();
		}

		[HttpPost]
		public IActionResult PatientInfo(string patientName, string patientID)
		{
			if(patientName == null)
			{
				Console.WriteLine("Records Using Patient ID");

				List<Patient> patient = new List<Patient>();
				List<Doctor> doctor = new List<Doctor>();
				List<MedicalHistory> medical = new List<MedicalHistory>();
				List<Consultant> consultant = new List<Consultant>();
                dynamic mymodel = new ExpandoObject();

                string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
				SqlConnection conn = new SqlConnection(connectionString);
                SqlConnection conn1= new SqlConnection(connectionString);
                conn.Open();
				conn1.Open();

				SqlCommand cmd = conn.CreateCommand();
				SqlCommand cmd1 = conn1.CreateCommand();

				cmd.CommandText = "select g.pat_id, g.name as Patient_Name ,g.DOB Date_of_Birth,e.doc_id   as Doctor_no,a.name as Doctor_Name,b.const_id,b.name as Consultant" +
                    "				from docteam_rec e,team d,juniordr a,consultant b,patient g,pataint_Incharge t where g.pat_id= @ID and  t.pat_id=g.pat_ID and t.doc_id=e.doc_id " +
                    "				and e.team_code=d.team_code and d.const_id=b.const_id and e.doc_id=a.doc_id;";


				cmd1.CommandText = "select serial_no as Treatment_no,Com_code,TRT_Code,Start_date,End_Date,Pat_id from medical_histroy where pat_id= @ID;";

                cmd.Parameters.AddWithValue("@ID", patientID);
				cmd1.Parameters.AddWithValue("@ID", patientID);

				SqlDataReader reader = cmd.ExecuteReader();
				SqlDataReader reader1 = cmd1.ExecuteReader();

				string patID = "";
				string patName = "";
				string patDob = "";
				string docID = "";
				string docName = "";
				string conID = "";
				string conName = "";
				string compCode = "";
				string trtCode = "";
				string start = "";
				string end = "";


				if(reader.Read())
				{
					patID = reader["pat_id"].ToString();
					patName = reader["Patient_Name"].ToString();
					patDob = reader["Date_of_Birth"].ToString();
					docID = reader["Doctor_no"].ToString();
					docName = reader["Doctor_Name"].ToString();
					conID = reader["const_id"].ToString();
					conName = reader["Consultant"].ToString();

					Patient patients = new Patient();
					Doctor doctors = new Doctor();
					Consultant consultants = new Consultant();

					patients.patientID = patID;
					patients.PatientName = patName;
					patients.PatientDOB = patDob;

					doctors.DoctorID = docID;
					doctors.DoctorName = docName;

					consultants.consultantID = conID;
					consultants.consultantName = conName;

					patient.Add(patients);
					consultant.Add(consultants);
					doctor.Add(doctors);

					
					mymodel.Doctor = doctor;
					mymodel.Patient = patient;
					mymodel.Consultant = consultant;
				}

				conn.Close();

				if(reader1.Read())
				{
					compCode = reader1["Com_code"].ToString();
					trtCode = reader1["TRT_Code"].ToString();
					start = reader1["Start_date"].ToString();
					end = reader1["End_Date"].ToString();

					MedicalHistory medicalH = new MedicalHistory();

					medicalH.complaintCode = compCode;
					medicalH.treatmentCode = trtCode;
					medicalH.startDate = start;
					medicalH.endDate = end;

					medical.Add(medicalH);

					mymodel.Medical = medical;

				}
				conn1.Close();

                return View(mymodel);
                
            }

			else
			{
				Console.WriteLine("Records Using Patient Name");
                List<Patient> patient = new List<Patient>();
                List<Doctor> doctor = new List<Doctor>();
                List<MedicalHistory> medical = new List<MedicalHistory>();
                List<Consultant> consultant = new List<Consultant>();
                dynamic mymodel = new ExpandoObject();

                string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True";
                SqlConnection conn = new SqlConnection(connectionString);
                SqlConnection conn1 = new SqlConnection(connectionString);
                conn.Open();
                conn1.Open();

                SqlCommand cmd = conn.CreateCommand();
                SqlCommand cmd1 = conn1.CreateCommand();

                cmd.CommandText = "select g.pat_id, g.name as Patient_Name ,g.DOB Date_of_Birth,e.doc_id   as Doctor_no,a.name as Doctor_Name,b.const_id,b.name as Consultant" +
                    "				from docteam_rec e,team d,juniordr a,consultant b,patient g,pataint_Incharge t where g.name= @name and  t.pat_id=g.pat_ID and t.doc_id=e.doc_id " +
                    "				and e.team_code=d.team_code and d.const_id=b.const_id and e.doc_id=a.doc_id;";


                cmd1.CommandText = "select serial_no as Treatment_no,Com_code,TRT_Code,Start_date,End_Date,p.Pat_id from medical_histroy m,patient p where p.name = @name";

                cmd.Parameters.AddWithValue("@name", patientName);
                cmd1.Parameters.AddWithValue("@name", patientName);

                SqlDataReader reader = cmd.ExecuteReader();
                SqlDataReader reader1 = cmd1.ExecuteReader();

                string patID = "";
                string patName = "";
                string patDob = "";
                string docID = "";
                string docName = "";
                string conID = "";
                string conName = "";
                string compCode = "";
                string trtCode = "";
                string start = "";
                string end = "";


                if (reader.Read())
                {
                    patID = reader["pat_id"].ToString();
                    patName = reader["Patient_Name"].ToString();
                    patDob = reader["Date_of_Birth"].ToString();
                    docID = reader["Doctor_no"].ToString();
                    docName = reader["Doctor_Name"].ToString();
                    conID = reader["const_id"].ToString();
                    conName = reader["Consultant"].ToString();

                    Patient patients = new Patient();
                    Doctor doctors = new Doctor();
                    Consultant consultants = new Consultant();

                    patients.patientID = patID;
                    patients.PatientName = patName;
                    patients.PatientDOB = patDob;

                    doctors.DoctorID = docID;
                    doctors.DoctorName = docName;

                    consultants.consultantID = conID;
                    consultants.consultantName = conName;

                    patient.Add(patients);
                    consultant.Add(consultants);
                    doctor.Add(doctors);


                    mymodel.Doctor = doctor;
                    mymodel.Patient = patient;
                    mymodel.Consultant = consultant;
                }

                conn.Close();

                if (reader1.Read())
                {
                    compCode = reader1["Com_code"].ToString();
                    trtCode = reader1["TRT_Code"].ToString();
                    start = reader1["Start_date"].ToString();
                    end = reader1["End_Date"].ToString();

                    MedicalHistory medicalH = new MedicalHistory();

                    medicalH.complaintCode = compCode;
                    medicalH.treatmentCode = trtCode;
                    medicalH.startDate = start;
                    medicalH.endDate = end;

                    medical.Add(medicalH);

                    mymodel.Medical = medical;

                }
                conn1.Close();

                return View(mymodel);
            }
			
		}

		[HttpPost]
		public IActionResult AddPatient(string patientID, string patientName, string address, string city, string phone, string dob)
		{
           
            string connectionString = "Server = DESKTOP-UF3LIAK\\SQLEXPRESS;Database=Hospital;Trusted_Connection=True; TrustServerCertificate=True;";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            SqlCommand cmd = conn.CreateCommand();
           
            cmd.CommandText = "Insert into Patient VALUES (@ID, @name, @address, @city, @phone, @dob)";
            cmd.Parameters.AddWithValue("@ID", patientID);
            cmd.Parameters.AddWithValue("@name", patientName);
			cmd.Parameters.AddWithValue("@address",address);
            cmd.Parameters.AddWithValue("@city", city);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@dob", dob);

            var res = cmd.ExecuteNonQuery();

			return View("PatientInput");
        }
	}
}
