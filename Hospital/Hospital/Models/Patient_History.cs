namespace Hospital.Models
{
    public class Patient_History
    {
        public string patientID { get; set; }
        public string patientName { get; set; } 
        public string careunit { get; set; }

        public string bedNo { get; set; }
        public string consultant { get; set; }
        public string admitDate { get; set; }

    }
}
